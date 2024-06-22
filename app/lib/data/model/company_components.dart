import 'package:app/data/model/assets_group.dart';
import 'package:app/data/model/company.dart';
import 'package:app/data/model/locations_group.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompanyComponents {
  CompanyComponents({
    required Company company,
    required Stream<List<AssetsGroup>> aloneAssets,
    required Stream<List<LocationsGroup>> locationsGoupList,
  })  : _company = company,
        _aloneAssets = aloneAssets,
        _locationsGroupList = locationsGoupList;

  late final Company _company;
  late final Stream<List<AssetsGroup>> _aloneAssets;
  late final Stream<List<LocationsGroup>> _locationsGroupList;

  Company get company => _company;

  Stream<List<AssetsGroup>> get aloneAssetsList => _aloneAssets;

  Stream<List<LocationsGroup>> get locationsGroupList => _locationsGroupList;
}
