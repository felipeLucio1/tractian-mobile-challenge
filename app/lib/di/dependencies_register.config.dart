// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i16;

import 'package:app/data/api/implementation/asset_api_impl.dart' as _i3;
import 'package:app/data/api/implementation/company_api_impl.dart' as _i4;
import 'package:app/data/api/implementation/location_api_impl.dart' as _i5;
import 'package:app/data/model/asset.dart' as _i9;
import 'package:app/data/model/assets_group.dart' as _i17;
import 'package:app/data/model/company.dart' as _i12;
import 'package:app/data/model/company_components.dart' as _i18;
import 'package:app/data/model/location.dart' as _i7;
import 'package:app/data/model/locations_group.dart' as _i15;
import 'package:app/data/model/result_component.dart' as _i11;
import 'package:app/data/model/search_obj.dart' as _i8;
import 'package:app/di/dependencies_register.dart' as _i6;
import 'package:app/domain/repository/repository.dart' as _i10;
import 'package:app/domain/usecases/asset_usecase.dart' as _i19;
import 'package:app/domain/usecases/company_components_usecase.dart' as _i21;
import 'package:app/domain/usecases/company_usecase.dart' as _i13;
import 'package:app/domain/usecases/component_usecase.dart' as _i20;
import 'package:app/domain/usecases/location_usecase.dart' as _i14;
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
    gh.factory<_i3.AssetApi>(() => _i3.AssetApi());
    gh.factory<_i4.CompanyApi>(() => _i4.CompanyApi());
    gh.factory<_i5.LocationApi>(() => _i5.LocationApi());
    gh.factory<_i6.LoggerWrapper>(() => _i6.LoggerWrapper());
    gh.factory<_i7.Location>(() => _i7.Location(
          id: gh<String>(),
          name: gh<String>(),
          parentId: gh<String>(),
        ));
    gh.factory<_i8.SearchObj>(() => _i8.SearchObj(
          gh<List<_i9.Asset>>(),
          gh<List<_i7.Location>>(),
        ));
    gh.lazySingleton<_i10.Repository>(() => _i10.Repository(
          gh<_i4.CompanyApi>(),
          gh<_i3.AssetApi>(),
          gh<_i5.LocationApi>(),
        ));
    gh.factory<_i11.ResultComponent>(() => _i11.ResultComponent(
          gh<String>(),
          gh<_i9.Asset>(),
          gh<_i7.Location>(),
        ));
    gh.factory<_i12.Company>(() => _i12.Company(
          id: gh<String>(),
          name: gh<String>(),
        ));
    gh.factory<_i13.CompanyUsecase>(
        () => _i13.CompanyUsecase(repo: gh<_i10.Repository>()));
    gh.factory<_i14.LocationUsecase>(
        () => _i14.LocationUsecase(repo: gh<_i10.Repository>()));
    gh.factory<_i15.LocationsGroup>(() => _i15.LocationsGroup(
          location: gh<_i7.Location>(),
          assetsGroupList: gh<_i16.Stream<List<_i17.AssetsGroup>>>(),
          sublocationsList: gh<_i16.Stream<List<_i15.LocationsGroup>>>(),
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
    gh.factory<_i18.CompanyComponents>(() => _i18.CompanyComponents(
          company: gh<_i12.Company>(),
          aloneAssets: gh<List<_i17.AssetsGroup>>(),
          locationsGoupList: gh<List<_i15.LocationsGroup>>(),
        ));
    gh.factory<_i19.AssetUsecase>(
        () => _i19.AssetUsecase(gh<_i10.Repository>()));
    gh.factory<_i17.AssetsGroup>(() => _i17.AssetsGroup(
          asset: gh<_i9.Asset>(),
          subAssetsList: gh<List<_i9.Asset>>(),
        ));
    gh.factory<_i20.ComponentUsecase>(
        () => _i20.ComponentUsecase(assetsUsecase: gh<_i19.AssetUsecase>()));
    gh.factory<_i21.CompanyComponentsUsecase>(
        () => _i21.CompanyComponentsUsecase(
              assetUseCase: gh<_i19.AssetUsecase>(),
              companyUsecase: gh<_i13.CompanyUsecase>(),
              componentUseCase: gh<_i20.ComponentUsecase>(),
              locationUseCase: gh<_i14.LocationUsecase>(),
            ));
    return this;
  }
}
