import 'package:app/domain/repository/repository.dart';
import 'package:injectable/injectable.dart';
import 'package:app/data/model/location.dart';

@injectable
class LocationUsecase {
  LocationUsecase({
    required Repository repo,
  }) : _repo = repo;

  late final Repository _repo;

  Stream<List<Location>> _getCompanyLocations(String id) =>
      _repo.getCompanyLocations(id);
}
