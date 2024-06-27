import 'package:app/data/model/asset.dart';
import 'package:app/data/model/location.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResultComponent {
  late final String? parentId;
  late final Asset? asset;
  late final Location? location;

  ResultComponent(
      this.parentId, this.asset, this.location);
}
