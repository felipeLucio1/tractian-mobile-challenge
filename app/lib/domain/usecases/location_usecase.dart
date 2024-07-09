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

  Future<List<LocationsGroup>> getCompanyAloneLocations(
      String companyId) async {
    await getLocationsList(companyId);
    List<LocationsGroup> aloneLocationsGroupList;
    List<Location> aloneLocationsList = [];
    for (var location in _locationsList) {
      if (location.parentId == null) {
        aloneLocationsList.add(location);
      }
    }

    aloneLocationsGroupList = _getAloneLocationsGroupList(aloneLocationsList);

    return aloneLocationsGroupList;
  }

  List<LocationsGroup> _getAloneLocationsGroupList(
      List<Location> locationsList) {
    final iterableLocationsList = locationsList;
    final List<LocationsGroup> aloneLocationsList = [];

    for (final location in iterableLocationsList) {
      if (location.parentId == null) {
        aloneLocationsList.add(LocationsGroup(
            location: location, assetsGroupList: [], sublocationsList: []));
      }
    }
    return aloneLocationsList;
  }

  List<LocationsGroup> getLocationChildren(String? parentId) {
    final iterableLocationsList = _locationsList;
    final List<LocationsGroup> locationChildrenList =
        _getLocationsGroupChildrenList(iterableLocationsList, parentId);

    return locationChildrenList;
  }

  List<LocationsGroup> _getLocationsGroupChildrenList(
      List<Location> iterableLocationsList, String? parentId) {
    List<LocationsGroup> locationChildrenList = [];
    for (final local in iterableLocationsList) {
      if (local.parentId == parentId) {
        locationChildrenList.add(LocationsGroup(
            location: local, assetsGroupList: [], sublocationsList: []));
      }
    }
    return locationChildrenList;
  }

  Future<List<Location>> getLocationsList(String companyId) async {
    _locationsList = await _repo.getCompanyLocations(companyId);
    return _locationsList;
  }
}
