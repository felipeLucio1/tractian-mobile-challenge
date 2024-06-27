import 'package:app/data/api/implementation/asset_api_impl.dart';
import 'package:app/data/api/implementation/company_api_impl.dart';
import 'package:app/data/api/implementation/location_api_impl.dart';
import 'package:app/di/dependencies_register.dart';
import 'package:app/domain/repository/repository.dart';
import 'package:app/feature/ui/start_screen.dart';
import 'package:flutter/material.dart';

late final AssetApi fetchAssetssApi;
late final CompanyApi fetchUserCompaniesApi;
late final LocationApi fetchLocationsApi;

void init() {
  setupDependencies();

  fetchAssetssApi = getitInstance<AssetApi>();
  fetchUserCompaniesApi = getitInstance<CompanyApi>();
  fetchLocationsApi = getitInstance<LocationApi>();
  Repository(fetchUserCompaniesApi, fetchAssetssApi, fetchLocationsApi);
}

void main() {
  init();

  runApp(const StartPage());
}
