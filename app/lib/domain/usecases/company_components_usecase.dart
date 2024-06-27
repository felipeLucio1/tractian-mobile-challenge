import 'package:app/data/model/company_components.dart';
import 'package:app/data/model/company.dart';
import 'package:app/domain/usecases/asset_usecase.dart';
import 'package:app/domain/usecases/company_usecase.dart';
import 'package:app/domain/usecases/component_usecase.dart';
import 'package:app/domain/usecases/location_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompanyComponentsUsecase {
  CompanyComponentsUsecase({
    required AssetUsecase assetUseCase,
    required CompanyUsecase companyUsecase,
    required ComponentUsecase componentUseCase,
    required LocationUsecase locationUseCase,
  })  : _componentUsecase = componentUseCase,
        _locationUsecase = locationUseCase;

  late final ComponentUsecase _componentUsecase;
  late final LocationUsecase _locationUsecase;

  Future<CompanyComponents> getAllCompanyAloneComponents(
      Company company) async {
    final CompanyComponents companyComponents;
    final aloneComponents = _componentUsecase.getAloneAssets(company.id);
    final locationsGoupList =
        _locationUsecase.getCompanyAloneLocations(company.id);

    companyComponents = CompanyComponents(
        company: company,
        aloneAssets: aloneComponents,
        locationsGoupList: locationsGoupList);

    return companyComponents;
  }
}
