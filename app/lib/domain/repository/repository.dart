import 'package:app/data/api/abstract/fetch_components_api.dart';
import 'package:app/data/model/asset.dart';
import 'package:app/data/model/company.dart';
import 'package:app/data/model/location.dart';
import 'package:injectable/injectable.dart';

@injectable
class Repository {
  const Repository({
    required FetchUserCompaniesApi fetchCompanies,
    required FetchAssetssApi fetchAssets,
    required FetchLocationsApi fetchLocations,
  })  : _fetchCompanies = fetchCompanies,
        _fetchAssets = fetchAssets,
        _fetchLocations = fetchLocations;

  final FetchUserCompaniesApi _fetchCompanies;
  final FetchAssetssApi _fetchAssets;
  final FetchLocationsApi _fetchLocations;

  Stream<List<Company>> getUserCompanies() async* {
    yield _fetchCompanies.fetchCompany() as List<Company>;
  }

  Stream<List<Asset>> getCompanyAssets(String companyId) async* {
    yield _fetchAssets.fetchAssets(companyId) as List<Asset>;
  }

  Stream<List<Location>> getCompanyLocations(String companyId) async* {
    yield _fetchLocations.fetchLocations(companyId) as List<Location>;
  }
}
