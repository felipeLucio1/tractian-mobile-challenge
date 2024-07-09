import 'package:app/data/model/assets_group.dart';
import 'package:app/data/model/company.dart';
import 'package:app/data/model/company_components.dart';
import 'package:app/data/model/locations_group.dart';
import 'package:app/di/dependencies_register.dart';
import 'package:app/domain/usecases/asset_usecase.dart';
import 'package:app/domain/usecases/company_components_usecase.dart';
import 'package:app/domain/usecases/location_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

part 'components_event.dart';
part 'components_state.dart';

class ComponentsBloc extends Bloc<ComponentsEvent, ComponentsState> {
  final _companyComponentsUsecase = getitInstance<CompanyComponentsUsecase>();
  final AssetUsecase _assetUseCase = getitInstance<AssetUsecase>();
  final _locationUseCase = getitInstance<LocationUsecase>();

  ComponentsBloc() : super(LoadingComponentsScreenState()) {
    on<LoadOrphanElementsEvent>((event, emit) async {
      final CompanyComponents componentsTree = await _companyComponentsUsecase
          .getAllCompanyAloneComponents(event.choosenCompany);

      LoggerWrapper().logger.log(Level.ALL, 'components tree: $componentsTree');

      emit(SuccessRetrievingElementsState(componentsTree));
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
  }
}
