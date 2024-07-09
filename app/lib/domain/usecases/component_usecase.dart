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

  Future<List<AssetsGroup>> getCompanyAloneAssets(String companyId) async {
    final List<Asset> allComponentsList =
        await _assetsUsecase.getAssetsList(companyId);
    List<AssetsGroup> aloneAssets = [];
    List<Asset> subAssetsList = [];
    AssetsGroup aloneAssetsGroup;

    for (final component in allComponentsList) {
      if (component.parentId == null) {
        aloneAssetsGroup =
            AssetsGroup(asset: component, subAssetsList: subAssetsList);
        aloneAssets.add(aloneAssetsGroup);
      }
    }

    return aloneAssets;
  }
}
