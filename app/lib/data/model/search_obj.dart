import 'package:app/data/model/asset.dart';
import 'package:app/data/model/location.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchObj {
  late final List<Location>? location;
  late final List<Asset>? assets;

  SearchObj(this.assets, this.location);
}
