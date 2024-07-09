import 'package:app/data/model/location.dart';
import 'package:app/data/model/assets_group.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationsGroup {
  late final Location location;
  List<AssetsGroup> assetsGroupList = [];
  List<LocationsGroup> sublocationsList = [];

  LocationsGroup(
      {required this.location,
      required this.assetsGroupList,
      required this.sublocationsList});
}
