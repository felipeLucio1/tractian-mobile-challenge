import 'package:app/data/model/location.dart';
import 'package:app/data/model/assets_group.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationsGroup {
  LocationsGroup({
    required Location location,
    required Stream<List<AssetsGroup>> assetsGroupList,
    required Stream<List<Location>> subLocationsList,
  })  : _location = location,
        _assetsGroupList = assetsGroupList,
        _sublocationsList = subLocationsList;

  late final Location _location;
  late final Stream<List<AssetsGroup>> _assetsGroupList;
  late final Stream<List<Location>> _sublocationsList;

  Location get location => _location;
  Stream<List<AssetsGroup>> get assetsGroupList => _assetsGroupList;
  Stream<List<Location>> get sublocationsList => _sublocationsList;
}
