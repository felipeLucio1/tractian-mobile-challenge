import 'dart:js_interop';

import 'package:app/data/model/asset.dart';
import 'package:app/data/model/company_components.dart';
import 'package:app/data/model/location.dart';
import 'package:app/data/model/result_component.dart';
import 'package:app/data/model/search_obj.dart';
import 'package:app/data/model/assets_group.dart';
import 'package:app/data/model/locations_group.dart';
import 'package:app/di/dependencies_register.dart';
import 'package:app/domain/usecases/asset_usecase.dart';
import 'package:app/domain/usecases/location_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchFilterUseCase {
  final assetUseCase = getitInstance<AssetUsecase>();
  final locationUseCase = getitInstance<LocationUsecase>();
  late final String companyId;

  SearchFilterUseCase({required String this.companyId});

  Stream<SearchObj> search(String searchInput) async* {
    final assets = assetUseCase.getAssetsList(companyId).single as List<Asset>;
    final locations =
        locationUseCase.getLocationsList(companyId) as List<Location>;

    yield SearchObj(
        assets.where((Asset asset) => asset.name.contains(searchInput))
            as List<Asset>,
        locations.where(
                (Location location) => location.name.contains(searchInput))
            as List<Location>);
  }

  Stream<List<ResultComponent>>? composeFoundResult(dynamic component) async* {
    ResultComponent? resultComponent = _mountResultComponent(component);

    List<ResultComponent> componentParent = [resultComponent!];
    String? parentId = resultComponent.parentId;
    while (parentId != null) {
      List<Asset> assetsList =
          assetUseCase.getAssetsList(companyId).single as List<Asset>;
      List<Location> locationsList =
          locationUseCase.getLocationsList(companyId).single as List<Location>;

      Asset? parentAsset = assetsList
          .where((Asset assetItem) => assetItem.id == parentId)
          .firstOrNull;
      Location? parentLocation = locationsList
          .where((Location locItem) => locItem.id == parentId)
          .firstOrNull;

      if (parentAsset != null) {
        parentId = parentAsset.parentId;
        componentParent.add(ResultComponent(parentId, parentAsset, null));
      } else if (parentLocation != null) {
        parentId = parentLocation.parentId;
        componentParent.add(ResultComponent(parentId, null, parentLocation));
      } else {
        parentId = null;
      }
    }

    yield componentParent.reversed.toList();
  }

  ResultComponent? _mountResultComponent(dynamic component) {
    late final ResultComponent? mountedComponent;

    switch (component.runtimeType) {
      case AssetsGroup _:
        AssetsGroup asset = component as AssetsGroup;
        mountedComponent =
            ResultComponent(asset.asset.parentId, asset.asset, null);
        break;
      case LocationsGroup _:
        LocationsGroup local = component as LocationsGroup;
        mountedComponent =
            ResultComponent(local.location.parentId, null, local.location);
        break;
      default:
        return null;
    }

    return mountedComponent;
  }
}
