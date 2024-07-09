import 'package:app/data/model/asset.dart';
import 'package:app/data/model/assets_group.dart';
import 'package:app/data/model/company.dart';
import 'package:app/data/model/locations_group.dart';
import 'package:app/data/model/result_component.dart';
import 'package:app/di/dependencies_register.dart';
import 'package:app/domain/usecases/asset_usecase.dart';
import 'package:app/domain/usecases/company_usecase.dart';
import 'package:app/domain/usecases/search_filter_usecase.dart';
import 'package:app/data/model/search_obj.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'start_screen_event.dart';
part 'start_screen_state.dart';

class StartScreenBloc extends Bloc<StartScreenEvent, StartScreenState> {
  final AssetUsecase _assetUseCase = getitInstance<AssetUsecase>();
  final _companyUseCase = getitInstance<CompanyUsecase>();
  late final Company _company;
  late final SearchFilterUseCase _searchFilterUseCase;

  StartScreenBloc() : super(LoadingScreenState()) {
    on<LoadingCompaniesEvent>((event, emit) async {
      final List<Company> companyusecase = await _companyUseCase.companies;
      if (companyusecase.isEmpty) {
        emit(ErrorDataRetrievingCompaniesState());
      } else {
        emit(SuccessDataRetrievingCompaniesState(companyusecase));
      }
    });

    on<SearchingOnAssetsListEvent>((event, emit) async {
      _searchFilterUseCase = SearchFilterUseCase(_company.id);
      emit(SearchFilterState(
          await _searchFilterUseCase.search(event.searchInput)));
    });

    on<ChoosingResultEvent>((event, emit) async {
      emit(ShowChoosenResultState(await _getResult(event)));
    });

    on<FilteringCriticalStatusSensorsEvent>((event, emit) async {
      List<Asset> assetsList = (await _assetUseCase.getAssetsList(_company.id))
          .where((Asset assetItem) => assetItem.status == 'critical')
          .toList();
      List<AssetsGroup> assetsGroup = [];
      List<List<ResultComponent>>? resultList = [];

      for (final item in assetsList) {
        assetsGroup.add(AssetsGroup(asset: item, subAssetsList: []));
      }

      for (var component in assetsGroup) {
        resultList.add(
            await _searchFilterUseCase.composeFoundResult(component) ?? []);
      }

      emit(FIlteringCricalStatusSensorsState(resultList));
    });

    on<FilteringEnergyTypeSensorsEvent>((event, emit) async {
      List<Asset> assetsList = (await _assetUseCase.getAssetsList(_company.id))
          .where((Asset assetItem) => assetItem.sensorType == 'energy')
          .toList();
      List<AssetsGroup> assetsGroup = [];
      List<List<ResultComponent>>? resultList = [];

      for (final item in assetsList) {
        assetsGroup.add(AssetsGroup(asset: item, subAssetsList: []));
      }

      for (var component in assetsGroup) {
        resultList.add(
            await _searchFilterUseCase.composeFoundResult(component) ?? []);
      }

      emit(FIlteringCricalStatusSensorsState(resultList));
    });
  }

  Future<List<ResultComponent>?> _getResult(ChoosingResultEvent event) async {
    if (event.assetGroupItem != null) {
      return await _searchFilterUseCase
              .composeFoundResult(event.assetGroupItem) ??
          [];
    } else if (event.locationGroupItem != null) {
      return _searchFilterUseCase.composeFoundResult(event.locationGroupItem);
    } else {
      return null;
    }
  }
}
