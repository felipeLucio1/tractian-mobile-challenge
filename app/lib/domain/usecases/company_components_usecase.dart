import 'package:app/data/model/assets_group.dart';
import 'package:app/data/model/company_components.dart';
import 'package:app/data/model/company.dart';
import 'package:app/data/model/locations_group.dart';
import 'package:app/domain/usecases/component_usecase.dart';
import 'package:app/domain/usecases/location_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompanyComponentsUsecase {
  CompanyComponentsUsecase({
    required ComponentUsecase componentUseCase,
    required LocationUsecase locationUseCase,
  })  : _componentUsecase = componentUseCase,
        _locationUsecase = locationUseCase;

  late final ComponentUsecase _componentUsecase;
  late final LocationUsecase _locationUsecase;

  Future<CompanyComponents> getAllCompanyAloneComponents(
      Company company) async {
    final CompanyComponents companyComponents;
    final List<AssetsGroup> aloneComponents =
        await _componentUsecase.getCompanyAloneAssets(company.id);
    final List<LocationsGroup> locationsGoupList =
        await _locationUsecase.getCompanyAloneLocations(company.id);

    companyComponents = CompanyComponents(
        company: company,
        aloneAssets: aloneComponents,
        locationsGoupList: locationsGoupList);

    return companyComponents;
  }
}
