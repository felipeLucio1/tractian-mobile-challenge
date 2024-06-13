import 'package:app/data/model/asset.dart';
import 'package:app/data/model/location.dart';
import 'package:app/data/model/company.dart';

abstract class FetchAssetssApi {
  Stream<List<Asset>> fetchAssets(String id);
}

abstract class FetchLocationsApi {
  Stream<List<Location>> fetchLocations(String id);
}

abstract class FetchUserCompaniesApi {
  Stream<List<Company>> fetchCompany();
}
