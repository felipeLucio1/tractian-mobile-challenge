import 'package:app/data/model/asset.dart';
import 'package:injectable/injectable.dart';

@injectable
class AssetsGroup {
  AssetsGroup({
    required Asset asset,
    required Stream<List<Asset>> subAssetsList,
  })  : _asset = asset,
        _subAssetsList = subAssetsList;

  late final Asset _asset;
  late final Stream<List<Asset>> _subAssetsList;

  Asset get asset => _asset;

  Stream<List<Asset>> get subAssetsList => _subAssetsList;
}
