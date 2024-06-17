import 'dart:async';
import 'package:app/data/model/assets_group.dart';
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
  Stream<List<Location>> _locationsList = const Stream.empty();

  Stream<List<LocationsGroup>> getCompanyAloneLocations(
      String companyId) async* {
    _populateLocationsList(companyId);
    final iterableLocationsList = _locationsList.single as List<Location>;
    final List<LocationsGroup> aloneLocationsList = [];

    for (final location in iterableLocationsList) {
      if (location.parentId == null) {
        aloneLocationsList.add(LocationsGroup(
            location: location,
            assetsGroupList: const Stream.empty(),
            subLocationsList: const Stream.empty()));
      }
    }

    yield aloneLocationsList;
  }

  Stream<List<Location>> getLocationChildren(String? parentId) async* {
    final iterableLocationsList = _locationsList.single as List<Location>;
    final List<Location> locationChildrenList = [];
    for (final e in iterableLocationsList) {
      if (e.parentId == parentId) locationChildrenList.add(e);
    }

    yield locationChildrenList;
  }

  Stream<List<Location>> _populateLocationsList(String companyId) =>
      _locationsList = _repo.getCompanyLocations(companyId);
}
