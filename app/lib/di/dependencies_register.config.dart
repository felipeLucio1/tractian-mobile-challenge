// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i18;

import 'package:app/data/api/abstract/fetch_components_api.dart' as _i11;
import 'package:app/data/api/implementation/asset_api_impl.dart' as _i7;
import 'package:app/data/api/implementation/company_api_impl.dart' as _i6;
import 'package:app/data/api/implementation/location_api_impl.dart' as _i4;
import 'package:app/data/model/asset.dart' as _i9;
import 'package:app/data/model/assets_group.dart' as _i19;
import 'package:app/data/model/company.dart' as _i13;
import 'package:app/data/model/company_components.dart' as _i20;
import 'package:app/data/model/location.dart' as _i5;
import 'package:app/data/model/locations_group.dart' as _i17;
import 'package:app/data/model/result_component.dart' as _i12;
import 'package:app/data/model/search_obj.dart' as _i8;
import 'package:app/di/dependencies_register.dart' as _i3;
import 'package:app/domain/repository/repository.dart' as _i10;
import 'package:app/domain/usecases/asset_usecase.dart' as _i14;
import 'package:app/domain/usecases/company_components_usecase.dart' as _i22;
import 'package:app/domain/usecases/company_usecase.dart' as _i15;
import 'package:app/domain/usecases/component_usecase.dart' as _i21;
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
    gh.lazySingleton<_i4.LocationApiImpl>(
      () => _i4.LocationApiImpl(),
      instanceName: 'LocationApiImpl',
    );
    gh.factory<_i5.Location>(() => _i5.Location(
          id: gh<String>(),
          name: gh<String>(),
          parentId: gh<String>(),
        ));
    gh.lazySingleton<_i6.CompanyApiImpl>(
      () => _i6.CompanyApiImpl(),
      instanceName: 'CompanyApiImpl',
    );
    gh.lazySingleton<_i7.AssetApiImpl>(
      () => _i7.AssetApiImpl(),
      instanceName: 'AssetApiImpl',
    );
    gh.factory<_i8.SearchObj>(() => _i8.SearchObj(
          gh<List<_i9.Asset>>(),
          gh<List<_i5.Location>>(),
        ));
    gh.lazySingleton<_i10.Repository>(() => _i10.Repository.from(
          fetchCompanies: gh<_i11.FetchUserCompaniesApi>(),
          fetchAssets: gh<_i11.FetchAssetssApi>(),
          fetchLocations: gh<_i11.FetchLocationsApi>(),
        ));
    gh.factory<_i12.ResultComponent>(() => _i12.ResultComponent(
          gh<String>(),
          gh<_i9.Asset>(),
          gh<_i5.Location>(),
        ));
    gh.factory<_i13.Company>(() => _i13.Company(
          id: gh<String>(),
          name: gh<String>(),
        ));
    gh.factory<_i14.AssetUsecase>(
        () => _i14.AssetUsecase(repo: gh<_i10.Repository>()));
    gh.factory<_i15.CompanyUsecase>(
        () => _i15.CompanyUsecase(repo: gh<_i10.Repository>()));
    gh.factory<_i16.LocationUsecase>(
        () => _i16.LocationUsecase(repo: gh<_i10.Repository>()));
    gh.factory<_i17.LocationsGroup>(() => _i17.LocationsGroup(
          location: gh<_i5.Location>(),
          assetsGroupList: gh<_i18.Stream<List<_i19.AssetsGroup>>>(),
          sublocationsList: gh<_i18.Stream<List<_i17.LocationsGroup>>>(),
        ));
    gh.factory<_i9.Asset>(() => _i9.Asset(
          id: gh<String>(),
          name: gh<String>(),
          parentId: gh<String>(),
          sensorId: gh<String>(),
          sensorType: gh<String>(),
          status: gh<String>(),
          gatwayId: gh<String>(),
          locationId: gh<String>(),
        ));
    gh.factory<_i20.CompanyComponents>(() => _i20.CompanyComponents(
          company: gh<_i13.Company>(),
          aloneAssets: gh<_i18.Stream<List<_i19.AssetsGroup>>>(),
          locationsGoupList: gh<_i18.Stream<List<_i17.LocationsGroup>>>(),
        ));
    gh.factory<_i21.ComponentUsecase>(
        () => _i21.ComponentUsecase(assetsUsecase: gh<_i14.AssetUsecase>()));
    gh.factory<_i19.AssetsGroup>(() => _i19.AssetsGroup(
          asset: gh<_i9.Asset>(),
          subAssetsList: gh<_i18.Stream<List<_i9.Asset>>>(),
        ));
    gh.factory<_i22.CompanyComponentsUsecase>(
        () => _i22.CompanyComponentsUsecase(
              assetUseCase: gh<_i14.AssetUsecase>(),
              companyUsecase: gh<_i15.CompanyUsecase>(),
              componentUseCase: gh<_i21.ComponentUsecase>(),
              locationUseCase: gh<_i16.LocationUsecase>(),
            ));
    return this;
  }
}
