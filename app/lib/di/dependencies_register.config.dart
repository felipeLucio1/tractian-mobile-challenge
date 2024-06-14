// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/data/api/abstract/fetch_components_api.dart' as _i3;
import 'package:app/data/api/implementation/asset_api_impl.dart' as _i6;
import 'package:app/data/api/implementation/company_api_impl.dart' as _i5;
import 'package:app/data/api/implementation/location_api_impl.dart' as _i4;
import 'package:app/domain/repository/repository.dart' as _i7;
import 'package:app/domain/usecases/asset_usecase.dart' as _i8;
import 'package:app/domain/usecases/component_usecase.dart' as _i10;
import 'package:app/domain/usecases/location_usecase.dart' as _i9;
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
    gh.factory<_i3.FetchUserCompaniesApi>(() => _i5.CompanyApiImpl());
    gh.factory<_i3.FetchAssetssApi>(() => _i6.AssetApiImpl());
    gh.factory<_i7.Repository>(() => _i7.Repository(
          fetchCompanies: gh<_i3.FetchUserCompaniesApi>(),
          fetchAssets: gh<_i3.FetchAssetssApi>(),
          fetchLocations: gh<_i3.FetchLocationsApi>(),
        ));
    gh.factory<_i8.AssetUsecase>(
        () => _i8.AssetUsecase(repo: gh<_i7.Repository>()));
    gh.factory<_i9.LocationUsecase>(
        () => _i9.LocationUsecase(repo: gh<_i7.Repository>()));
    gh.factory<_i10.ComponentUsecase>(
        () => _i10.ComponentUsecase(assetsUsecase: gh<_i8.AssetUsecase>()));
    return this;
  }
}
