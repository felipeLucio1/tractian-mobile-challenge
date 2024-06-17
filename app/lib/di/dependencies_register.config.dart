// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;

import 'package:app/data/api/abstract/fetch_components_api.dart' as _i3;
import 'package:app/data/api/implementation/asset_api_impl.dart' as _i7;
import 'package:app/data/api/implementation/company_api_impl.dart' as _i6;
import 'package:app/data/api/implementation/location_api_impl.dart' as _i4;
import 'package:app/data/model/asset.dart' as _i11;
import 'package:app/data/model/assets_group.dart' as _i10;
import 'package:app/data/model/company.dart' as _i13;
import 'package:app/data/model/company_components.dart' as _i17;
import 'package:app/data/model/location.dart' as _i5;
import 'package:app/data/model/locations_group.dart' as _i8;
import 'package:app/domain/repository/repository.dart' as _i12;
import 'package:app/domain/usecases/asset_usecase.dart' as _i14;
import 'package:app/domain/usecases/company_components_usecase.dart' as _i19;
import 'package:app/domain/usecases/company_usecase.dart' as _i15;
import 'package:app/domain/usecases/component_usecase.dart' as _i18;
import 'package:app/domain/usecases/location_usecase.dart' as _i16;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.FetchLocationsApi>(() => _i4.LocationApiImpl());
    gh.factory<_i5.Location>(() => _i5.Location(
          id: gh<dynamic>(),
          name: gh<dynamic>(),
          parentId: gh<dynamic>(),
        ));
    gh.factory<_i3.FetchUserCompaniesApi>(() => _i6.CompanyApiImpl());
    gh.factory<_i3.FetchAssetssApi>(() => _i7.AssetApiImpl());
    gh.factory<_i8.LocationsGroup>(() => _i8.LocationsGroup(
          location: gh<_i5.Location>(),
          assetsGroupList: gh<_i9.Stream<List<_i10.AssetsGroup>>>(),
          subLocationsList: gh<_i9.Stream<List<_i5.Location>>>(),
        ));
    gh.factory<_i11.Asset>(() => _i11.Asset(
          id: gh<dynamic>(),
          name: gh<dynamic>(),
          parentId: gh<dynamic>(),
          sensorId: gh<dynamic>(),
          sensorType: gh<dynamic>(),
          status: gh<dynamic>(),
          gatwayId: gh<dynamic>(),
          locationId: gh<dynamic>(),
        ));
    gh.factory<_i12.Repository>(() => _i12.Repository(
          fetchCompanies: gh<_i3.FetchUserCompaniesApi>(),
          fetchAssets: gh<_i3.FetchAssetssApi>(),
          fetchLocations: gh<_i3.FetchLocationsApi>(),
        ));
    gh.factory<_i13.Company>(() => _i13.Company(
          id: gh<String>(),
          name: gh<String>(),
        ));
    gh.factory<_i10.AssetsGroup>(() => _i10.AssetsGroup(
          asset: gh<_i11.Asset>(),
          subAssetsList: gh<_i9.Stream<List<_i11.Asset>>>(),
        ));
    gh.factory<_i14.AssetUsecase>(
        () => _i14.AssetUsecase(repo: gh<_i12.Repository>()));
    gh.factory<_i15.CompanyUsecase>(
        () => _i15.CompanyUsecase(repo: gh<_i12.Repository>()));
    gh.factory<_i16.LocationUsecase>(
        () => _i16.LocationUsecase(repo: gh<_i12.Repository>()));
    gh.factory<_i17.CompanyComponents>(() => _i17.CompanyComponents(
          company: gh<_i13.Company>(),
          aloneAssets: gh<_i9.Stream<List<_i10.AssetsGroup>>>(),
          locationsGoupList: gh<_i9.Stream<List<_i8.LocationsGroup>>>(),
        ));
    gh.factory<_i18.ComponentUsecase>(
        () => _i18.ComponentUsecase(assetsUsecase: gh<_i14.AssetUsecase>()));
    gh.factory<_i19.CompanyComponentsUsecase>(
        () => _i19.CompanyComponentsUsecase(
              assetUseCase: gh<_i14.AssetUsecase>(),
              companyUsecase: gh<_i15.CompanyUsecase>(),
              componentUseCase: gh<_i18.ComponentUsecase>(),
              locationUseCase: gh<_i16.LocationUsecase>(),
            ));
    return this;
  }
}
