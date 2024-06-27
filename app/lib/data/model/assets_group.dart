import 'package:app/data/model/asset.dart';
import 'package:injectable/injectable.dart';

@injectable
class AssetsGroup {
  AssetsGroup({
    required Asset asset,
    required List<Asset> subAssetsList,
  })  : _asset = asset,
        _subAssetsList = subAssetsList;

  late final Asset _asset;
  late final List<Asset> _subAssetsList;

  Asset get asset => _asset;

  List<Asset> get subAssetsList => _subAssetsList;
}
