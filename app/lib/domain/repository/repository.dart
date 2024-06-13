import 'package:app/data/api/abstract/fetch_components_api.dart';
import 'package:app/data/model/asset.dart';
import 'package:app/data/model/company.dart';
import 'package:app/data/model/location.dart';

class Repository {
  const Repository({
    required FetchUserCompaniesApi companies,
    required FetchAssetssApi assets,
    required FetchLocationsApi locations,
  })  : _companies = companies,
        _assets = assets,
        _companyLocations = locations;

  final FetchUserCompaniesApi _companies;
  final FetchAssetssApi _assets;
  final FetchLocationsApi _companyLocations;

  Stream<List<Company>> getUserCompanies() async* {
    yield _companies.fetchCompany() as List<Company>;
  }

  Stream<List<Asset>> getCompanyAssets(String companyId) async* {
    yield _assets.fetchAssets(companyId) as List<Asset>;
  }

  Stream<List<Location>> getCompanyLocations(String companyId) async* {
    yield _companyLocations.fetchLocations(companyId) as List<Location>;
  }
}
