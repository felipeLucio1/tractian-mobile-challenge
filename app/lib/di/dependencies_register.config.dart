// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;

import 'package:app/data/api/abstract/fetch_components_api.dart' as _i4;
import 'package:app/data/api/implementation/asset_api_impl.dart' as _i8;
import 'package:app/data/api/implementation/company_api_impl.dart' as _i7;
import 'package:app/data/api/implementation/location_api_impl.dart' as _i5;
import 'package:app/data/model/asset.dart' as _i17;
import 'package:app/data/model/assets_group.dart' as _i11;
import 'package:app/data/model/company.dart' as _i13;
import 'package:app/data/model/company_components.dart' as _i18;
import 'package:app/data/model/location.dart' as _i6;
import 'package:app/data/model/locations_group.dart' as _i9;
import 'package:app/di/dependencies_register.dart' as _i3;
import 'package:app/domain/repository/repository.dart' as _i12;
import 'package:app/domain/usecases/asset_usecase.dart' as _i14;
import 'package:app/domain/usecases/company_components_usecase.dart' as _i20;
import 'package:app/domain/usecases/company_usecase.dart' as _i15;
import 'package:app/domain/usecases/component_usecase.dart' as _i19;
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
    gh.factory<_i3.LoggerWrapper>(() => _i3.LoggerWrapper());
    gh.factory<_i4.FetchLocationsApi>(() => _i5.LocationApiImpl());
    gh.factory<_i6.Location>(() => _i6.Location(
          id: gh<dynamic>(),
          name: gh<dynamic>(),
          parentId: gh<dynamic>(),
        ));
    gh.factory<_i4.FetchUserCompaniesApi>(() => _i7.CompanyApiImpl());
    gh.factory<_i4.FetchAssetssApi>(() => _i8.AssetApiImpl());
    gh.factory<_i9.LocationsGroup>(() => _i9.LocationsGroup(
          location: gh<_i6.Location>(),
          assetsGroupList: gh<_i10.Stream<List<_i11.AssetsGroup>>>(),
          subLocationsList: gh<_i10.Stream<List<_i6.Location>>>(),
        ));
    gh.factory<_i12.Repository>(() => _i12.Repository(
          fetchCompanies: gh<_i4.FetchUserCompaniesApi>(),
          fetchAssets: gh<_i4.FetchAssetssApi>(),
          fetchLocations: gh<_i4.FetchLocationsApi>(),
        ));
    gh.factory<_i13.Company>(() => _i13.Company(
          id: gh<String>(),
          name: gh<String>(),
        ));
    gh.factory<_i14.AssetUsecase>(
        () => _i14.AssetUsecase(repo: gh<_i12.Repository>()));
    gh.factory<_i15.CompanyUsecase>(
        () => _i15.CompanyUsecase(repo: gh<_i12.Repository>()));
    gh.factory<_i16.LocationUsecase>(
        () => _i16.LocationUsecase(repo: gh<_i12.Repository>()));
    gh.factory<_i17.Asset>(() => _i17.Asset(
          id: gh<String>(),
          name: gh<String>(),
          parentId: gh<String>(),
          sensorId: gh<String>(),
          sensorType: gh<String>(),
          status: gh<String>(),
          gatwayId: gh<String>(),
          locationId: gh<String>(),
        ));
    gh.factory<_i18.CompanyComponents>(() => _i18.CompanyComponents(
          company: gh<_i13.Company>(),
          aloneAssets: gh<_i10.Stream<List<_i11.AssetsGroup>>>(),
          locationsGoupList: gh<_i10.Stream<List<_i9.LocationsGroup>>>(),
        ));
    gh.factory<_i19.ComponentUsecase>(
        () => _i19.ComponentUsecase(assetsUsecase: gh<_i14.AssetUsecase>()));
    gh.factory<_i11.AssetsGroup>(() => _i11.AssetsGroup(
          asset: gh<_i17.Asset>(),
          subAssetsList: gh<_i10.Stream<List<_i17.Asset>>>(),
        ));
    gh.factory<_i20.CompanyComponentsUsecase>(
        () => _i20.CompanyComponentsUsecase(
              assetUseCase: gh<_i14.AssetUsecase>(),
              companyUsecase: gh<_i15.CompanyUsecase>(),
              componentUseCase: gh<_i19.ComponentUsecase>(),
              locationUseCase: gh<_i16.LocationUsecase>(),
            ));
    return this;
  }
}
