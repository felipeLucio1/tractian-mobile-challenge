import 'package:app/domain/repository/repository.dart';
import 'package:app/data/model/company.dart';

class CompanyUsecase {
  CompanyUsecase({
    required Repository repo,
  }) : _repo = repo;

  late final Repository _repo;
  Stream<List<Company>> _companiesList = const Stream.empty();

  Stream<List<Company>> _getAllCompanies() =>
      _companiesList = _repo.getUserCompanies();

  Stream<List<Company>> get companies => _getAllCompanies();
}
