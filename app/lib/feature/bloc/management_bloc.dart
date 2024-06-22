import 'package:app/data/model/asset.dart';
import 'package:app/data/model/assets_group.dart';
import 'package:app/data/model/company.dart';
import 'package:app/data/model/company_components.dart';
import 'package:app/data/model/locations_group.dart';
import 'package:app/data/model/result_component.dart';
import 'package:app/di/dependencies_register.dart';
import 'package:app/domain/repository/repository.dart';
import 'package:app/domain/usecases/asset_usecase.dart';
import 'package:app/domain/usecases/company_components_usecase.dart';
import 'package:app/domain/usecases/company_usecase.dart';
import 'package:app/domain/usecases/location_usecase.dart';
import 'package:app/domain/usecases/component_usecase.dart';
import 'package:app/domain/usecases/search_filter_usecase.dart';
import 'package:app/data/model/search_obj.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'management_event.dart';
part 'management_state.dart';

class ManagementBloc extends Bloc<ManagementEvent, ManagementState> {
  final repository = getitInstance<Repository>();
  final assetUseCase = getitInstance<AssetUsecase>();
  final companyUseCase = getitInstance<CompanyUsecase>();
  final componentUseCase = getitInstance<ComponentUsecase>();
  final locationUseCase = getitInstance<LocationUsecase>();
  final companyComponentsUsecase = getitInstance<CompanyComponentsUsecase>();
  late final Company company;
  late final SearchFilterUseCase searchFilterUseCase;
  late final Stream<CompanyComponents> componentsTree;

  ManagementBloc() : super(LoadingScreenState()) {
    on<LoadingCompaniesEvent>((event, emit) {
      final companyusecase = companyUseCase.companies;
      if (companyusecase.isEmpty as bool) {
        emit(ErrorDataRetrievingCompaniesState());
      } else {
        emit(SuccessDataRetrievingCompaniesState(companyusecase));
      }
    });

    on<LoadOrphanElementsEvent>((event, emit) {
      company = event.company;
      componentsTree =
          companyComponentsUsecase.getAllCompanyAloneComponents(company);

      componentsTree.isEmpty.then((isEmpty) {
        isEmpty
            ? emit(ErrorDataRetrievingCompanyElementsState())
            : emit(SuccessRetrievingCompanyElementsState(componentsTree));
      });
    });

    on<LoadingElementInfoEvent>((event, emit) {
      final AssetsGroup? assetsGroupItem = event.assetGroup;
      final LocationsGroup? locationsGroupItem = event.locationGroup;
      if (assetsGroupItem != null && locationsGroupItem == null) {
        emit(SuccessRetrievingAssetInfoState(
            assetUseCase.getAssetsChildren(assetsGroupItem.asset.id)));
      } else if (locationsGroupItem != null && assetsGroupItem == null) {
        locationsGroupItem.sublocationsList =
            locationUseCase.getLocationChildren(locationsGroupItem.location.id);
        emit(SuccessRetrievingSublocationsInfoState(
            locationsGroupItem.sublocationsList));
      } else {
        emit(ErrorRetrievingElementInfoState());
      }
    });

    on<SearchingOnAssetsListEvent>((event, emit) {
      searchFilterUseCase = SearchFilterUseCase(company.id);
      emit(SearchFilterState(searchFilterUseCase.search(event.searchInput)));
    });

    on<ChoosingResultEvent>((event, emit) {
      emit(ShowChoosenResultState(_getResult(event)));
    });

    on<FilteringCriticalStatusSensorsEvent>((event, emit) {
      List<Asset> assetsList =
          (assetUseCase.getAssetsList(company.id).single as List<Asset>)
              .where((Asset assetItem) => assetItem.status == 'critical')
              .toList();
      List<AssetsGroup> assetsGroup = [];
      List<List<ResultComponent>>? resultList = [];

      for (final item in assetsList) {
        assetsGroup
            .add(AssetsGroup(asset: item, subAssetsList: const Stream.empty()));
      }

      for (var component in assetsGroup) {
        resultList.add(searchFilterUseCase.composeFoundResult(component)?.single
            as List<ResultComponent>);
      }

      emit(FIlteringCricalStatusSensorsState(
          Stream.fromIterable(Iterable.castFrom(resultList))));
    });

    on<FilteringEnergyTypeSensorsEvent>((event, emit) {
      List<Asset> assetsList =
          (assetUseCase.getAssetsList(company.id).single as List<Asset>)
              .where((Asset assetItem) => assetItem.sensorType == 'energy')
              .toList();
      List<AssetsGroup> assetsGroup = [];
      List<List<ResultComponent>>? resultList = [];

      for (final item in assetsList) {
        assetsGroup
            .add(AssetsGroup(asset: item, subAssetsList: const Stream.empty()));
      }

      for (var component in assetsGroup) {
        resultList.add(searchFilterUseCase.composeFoundResult(component)?.single
            as List<ResultComponent>);
      }

      emit(FIlteringCricalStatusSensorsState(
          Stream.fromIterable(Iterable.castFrom(resultList))));
    });
  }

  Stream<List<ResultComponent>> _getResult(ChoosingResultEvent event) async* {
    event.assetGroupItem != null
        ? searchFilterUseCase.composeFoundResult(event.assetGroupItem)
        : event.locationGroupItem != null
            ? searchFilterUseCase.composeFoundResult(event.locationGroupItem)
            : null;
  }
}
