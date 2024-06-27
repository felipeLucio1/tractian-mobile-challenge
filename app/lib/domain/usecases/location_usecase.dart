import 'dart:async';
import 'package:app/data/model/locations_group.dart';
import 'package:app/domain/repository/repository.dart';
import 'package:injectable/injectable.dart';
import 'package:app/data/model/location.dart';

@injectable
class LocationUsecase {
  LocationUsecase({
    required Repository repo,
  }) {
    _repo = repo;
  }

  late final Repository _repo;
  List<Location> _locationsList = [];

  List<LocationsGroup> getCompanyAloneLocations(String companyId) {
    getLocationsList(companyId);
    List<LocationsGroup> aloneLocationsList =
        _getAloneLocationsGroupList(_locationsList.single as List<Location>);

    return aloneLocationsList;
  }

  List<LocationsGroup> _getAloneLocationsGroupList(
      List<Location> locationsList) {
    final iterableLocationsList = locationsList;
    final List<LocationsGroup> aloneLocationsList = [];

    for (final location in iterableLocationsList) {
      if (location.parentId == null) {
        aloneLocationsList.add(LocationsGroup(
            location: location,
            assetsGroupList: const Stream.empty(),
            sublocationsList: const Stream.empty()));
      }
    }
    return aloneLocationsList;
  }

  Stream<List<LocationsGroup>> getLocationChildren(String? parentId) async* {
    final iterableLocationsList = _locationsList.single as List<Location>;
    final List<LocationsGroup> locationChildrenList =
        _getLocationsGroupChildrenList(iterableLocationsList, parentId);

    yield locationChildrenList;
  }

  List<LocationsGroup> _getLocationsGroupChildrenList(
      List<Location> iterableLocationsList, String? parentId) {
    List<LocationsGroup> locationChildrenList = [];
    for (final local in iterableLocationsList) {
      if (local.parentId == parentId) {
        locationChildrenList.add(LocationsGroup(
            location: local,
            assetsGroupList: const Stream.empty(),
            sublocationsList: const Stream.empty()));
      }
    }
    return locationChildrenList;
  }

  Future<List<Location>> getLocationsList(String companyId) async {
    _locationsList = await _repo.getCompanyLocations(companyId);
    return _locationsList;
  }
}
