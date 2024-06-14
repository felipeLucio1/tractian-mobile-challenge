import 'package:app/domain/repository/repository.dart';
import 'package:app/data/model/asset.dart';
import 'package:injectable/injectable.dart';

@injectable
class AssetUsecase {
  AssetUsecase({
    required Repository repo,
  }) : _repo = repo;

  late final Repository _repo;
  final Stream<List<Asset>> _assetsList = const Stream.empty();

  Stream<List<Asset>> get assetsWithoutParentAndLocation {
    return _assetsList.where(
        (List<Asset> assets) => assets.forEach(_assetWithoutParent) as bool);
  }

  bool _assetWithoutParent(Asset asset) {
    return asset.locationId == null && asset.locationId == null;
  }
}
