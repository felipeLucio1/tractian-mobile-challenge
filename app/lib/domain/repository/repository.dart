import 'package:app/data/api/implementation/asset_api_impl.dart';
import 'package:app/data/api/implementation/company_api_impl.dart';
import 'package:app/data/api/implementation/location_api_impl.dart';
import 'package:app/data/model/asset.dart';
import 'package:app/data/model/company.dart';
import 'package:app/data/model/location.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class Repository {
  @factoryMethod
  const Repository(
    this._fetchCompanies,
    this._fetchAssets,
    this._fetchLocations,
  );

  final CompanyApi _fetchCompanies;
  final AssetApi _fetchAssets;
  final LocationApi _fetchLocations;

  Future<List<Company>> getUserCompanies() async {
    return _fetchCompanies.fetchCompany();
  }

  Stream<List<Asset>> getCompanyAssets(String companyId) async* {
    _fetchAssets.fetchAssets(companyId);
  }

  Future<List<Location>> getCompanyLocations(String companyId) async {
    return _fetchLocations.fetchLocations(companyId);
  }
}
