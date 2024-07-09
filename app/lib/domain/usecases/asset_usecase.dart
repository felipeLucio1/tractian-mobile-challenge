import 'package:app/data/model/assets_group.dart';
import 'package:app/domain/repository/repository.dart';
import 'package:app/data/model/asset.dart';
import 'package:injectable/injectable.dart';

@injectable
class AssetUsecase {
  AssetUsecase(this._repo);

  late final Repository _repo;
  List<Asset> _assetsList = List<Asset>.empty();

  Future<List<Asset>> getAssetsList(String companyId) async =>
      await _getAssets(companyId);

  Future<List<Asset>> _getAssets(String companyId) async {
    _assetsList = await _repo.getCompanyAssets(companyId);

    return _assetsList;
  }

  bool _assetsWithoutSensor(Asset asset) {
    return asset.sensorId == null;
  }

  List<AssetsGroup> getAssetsChildren(String assetId) {
    final List<AssetsGroup> childrenAssetsGroup = [];

    for (final asset in _assetsList) {
      if (asset.parentId == assetId) {
        childrenAssetsGroup.add(AssetsGroup(asset: asset, subAssetsList: []));
      }
    }

    return childrenAssetsGroup;
  }
}
