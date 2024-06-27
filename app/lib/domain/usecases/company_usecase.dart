import 'package:app/domain/repository/repository.dart';
import 'package:app/data/model/company.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompanyUsecase {
  CompanyUsecase({
    required Repository repo,
  }) : _repo = repo;

  late final Repository _repo;

  Future<List<Company>> get companies => _repo.getUserCompanies();
}
