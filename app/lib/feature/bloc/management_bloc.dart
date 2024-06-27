import 'dart:async';

import 'package:app/data/model/asset.dart';
import 'package:app/data/model/assets_group.dart';
import 'package:app/data/model/company.dart';
import 'package:app/data/model/company_components.dart';
import 'package:app/data/model/locations_group.dart';
import 'package:app/data/model/result_component.dart';
import 'package:app/di/dependencies_register.dart';
import 'package:app/domain/usecases/asset_usecase.dart';
import 'package:app/domain/usecases/company_components_usecase.dart';
import 'package:app/domain/usecases/company_usecase.dart';
import 'package:app/domain/usecases/location_usecase.dart';
import 'package:app/domain/usecases/search_filter_usecase.dart';
import 'package:app/data/model/search_obj.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'management_event.dart';
part 'management_state.dart';

class ManagementBloc extends Bloc<ManagementEvent, ManagementState> {
  final AssetUsecase _assetUseCase = getitInstance<AssetUsecase>();
  final _companyUseCase = getitInstance<CompanyUsecase>();
  final _locationUseCase = getitInstance<LocationUsecase>();
  final _companyComponentsUsecase = getitInstance<CompanyComponentsUsecase>();
  late final Company _company;
  late final SearchFilterUseCase _searchFilterUseCase;
  late final Future<CompanyComponents> _componentsTree;

  ManagementBloc() : super(LoadingScreenState()) {
    on<LoadingCompaniesEvent>((event, emit) async {
      final companyusecase = await _companyUseCase.companies;
      if (companyusecase.isEmpty) {
        emit(ErrorDataRetrievingCompaniesState());
      } else {
        emit(SuccessDataRetrievingCompaniesState(companyusecase));
      }
    });

    on<LoadOrphanElementsEvent>((event, emit) {
      _company = event.company;
      _componentsTree =
          _companyComponentsUsecase.getAllCompanyAloneComponents(_company);

      _componentsTree.asStream().isEmpty.then((isEmpty) {
        isEmpty
            ? emit(ErrorDataRetrievingCompanyElementsState())
            : emit(SuccessRetrievingCompanyElementsState(_componentsTree));
      });
    });

    on<LoadingElementInfoEvent>((event, emit) {
      final AssetsGroup? assetsGroupItem = event.assetGroup;
      final LocationsGroup? locationsGroupItem = event.locationGroup;
      if (assetsGroupItem != null && locationsGroupItem == null) {
        emit(SuccessRetrievingAssetInfoState(
            _assetUseCase.getAssetsChildren(assetsGroupItem.asset.id)));
      } else if (locationsGroupItem != null && assetsGroupItem == null) {
        locationsGroupItem.sublocationsList = _locationUseCase
            .getLocationChildren(locationsGroupItem.location.id);
        emit(SuccessRetrievingSublocationsInfoState(
            locationsGroupItem.sublocationsList));
      } else {
        emit(ErrorRetrievingElementInfoState());
      }
    });

    on<SearchingOnAssetsListEvent>((event, emit) {
      _searchFilterUseCase = SearchFilterUseCase(_company.id);
      emit(SearchFilterState(_searchFilterUseCase.search(event.searchInput)));
    });

    on<ChoosingResultEvent>((event, emit) {
      emit(ShowChoosenResultState(_getResult(event)));
    });

    on<FilteringCriticalStatusSensorsEvent>((event, emit) {
      List<Asset> assetsList =
          (_assetUseCase.getAssetsList(_company.id).single as List<Asset>)
              .where((Asset assetItem) => assetItem.status == 'critical')
              .toList();
      List<AssetsGroup> assetsGroup = [];
      List<List<ResultComponent>>? resultList = [];

      for (final item in assetsList) {
        assetsGroup.add(AssetsGroup(asset: item, subAssetsList: []));
      }

      for (var component in assetsGroup) {
        resultList.add(_searchFilterUseCase
            .composeFoundResult(component)
            ?.single as List<ResultComponent>);
      }

      emit(FIlteringCricalStatusSensorsState(resultList));
    });

    on<FilteringEnergyTypeSensorsEvent>((event, emit) {
      List<Asset> assetsList =
          (_assetUseCase.getAssetsList(_company.id).single as List<Asset>)
              .where((Asset assetItem) => assetItem.sensorType == 'energy')
              .toList();
      List<AssetsGroup> assetsGroup = [];
      List<List<ResultComponent>>? resultList = [];

      for (final item in assetsList) {
        assetsGroup.add(AssetsGroup(asset: item, subAssetsList: []));
      }

      for (var component in assetsGroup) {
        resultList.add(_searchFilterUseCase
            .composeFoundResult(component)
            ?.single as List<ResultComponent>);
      }

      emit(FIlteringCricalStatusSensorsState(resultList));
    });
  }

  List<ResultComponent>? _getResult(ChoosingResultEvent event) {
    return event.assetGroupItem != null
        ? _searchFilterUseCase.composeFoundResult(event.assetGroupItem)
        : event.locationGroupItem != null
            ? _searchFilterUseCase.composeFoundResult(event.locationGroupItem)
            : null;
  }
}
