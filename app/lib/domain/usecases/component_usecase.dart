import 'package:app/domain/repository/repository.dart';
import 'package:app/data/model/asset.dart';
import 'package:app/domain/usecases/asset_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class ComponentUsecase {
  ComponentUsecase({
    required Repository repo,
  }) : _repo = repo;

  late final Repository _repo;
  Stream<List<Asset>> _componentsList = Stream.empty();

  //Stream<List<Asset>> getComponents(String companyId) {}
}
