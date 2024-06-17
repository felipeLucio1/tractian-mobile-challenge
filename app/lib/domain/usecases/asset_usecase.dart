import 'package:app/data/model/assets_group.dart';
import 'package:app/domain/repository/repository.dart';
import 'package:app/data/model/asset.dart';
import 'package:injectable/injectable.dart';

@injectable
class AssetUsecase {
  AssetUsecase({
    required Repository repo,
  }) : _repo = repo;

  late final Repository _repo;
  Stream<List<Asset>> _assetsList = const Stream.empty();

  Stream<List<Asset>> getAssetsList(String companyId) => _getAssets(companyId);

  Stream<List<Asset>> _getAssets(String companyId) {
    _assetsList = _repo.getCompanyAssets(companyId);

    return _assetsList.where(
        (List<Asset> assets) => assets.forEach(_assetsWithoutSensor) as bool);
  }

  bool _assetsWithoutSensor(Asset asset) {
    return asset.sensorId == null;
  }

  Stream<List<AssetsGroup>> getAssetsChildren(String assetId) async* {
    final iterableAssetsList = _assetsList.single as List<Asset>;
    final List<AssetsGroup> childrenAssetsGroup = [];

    for (final asset in iterableAssetsList) {
      if (asset.parentId == assetId) {
        childrenAssetsGroup.add(
            AssetsGroup(asset: asset, subAssetsList: const Stream.empty()));
      }
    }

    yield childrenAssetsGroup;
  }
}
