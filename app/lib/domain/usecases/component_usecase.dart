import 'dart:async';

import 'package:app/data/model/assets_group.dart';
import 'package:app/data/model/asset.dart';
import 'package:app/domain/usecases/asset_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class ComponentUsecase {
  ComponentUsecase({
    required AssetUsecase assetsUsecase,
  }) : _assetsUsecase = assetsUsecase;

  late final AssetUsecase _assetsUsecase;

  Stream<List<AssetsGroup>> getAloneAssets(String companyId) async* {
    final allComponentsList =
        _assetsUsecase.getAssetsList(companyId).single as List<Asset>;
    List<AssetsGroup> aloneAssets = [];
    Stream<List<Asset>> subAsstsList = const Stream.empty();
    AssetsGroup aloneAssetsGroup;

    for (final component in allComponentsList) {
      if (component.parentId == null) {
        aloneAssetsGroup =
            AssetsGroup(asset: component, subAssetsList: subAsstsList);
        aloneAssets.add(aloneAssetsGroup);
      }
    }

    yield aloneAssets;
  }
}
