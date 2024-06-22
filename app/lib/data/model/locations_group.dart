import 'package:app/data/model/location.dart';
import 'package:app/data/model/assets_group.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationsGroup {
  late final Location location;
  Stream<List<AssetsGroup>> assetsGroupList = const Stream.empty();
  Stream<List<LocationsGroup>> sublocationsList = const Stream.empty();

  LocationsGroup(
      {required Location this.location,
      required Stream<List<AssetsGroup>> this.assetsGroupList,
      required Stream<List<LocationsGroup>> this.sublocationsList});
}
