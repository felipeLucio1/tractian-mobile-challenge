import 'package:injectable/injectable.dart';

@injectable
class Asset {
  late final String _id;
  late final String _name;
  late final String? _parentId;
  late final String? _sensorId;
  late final String _sensorType;
  late final String _status;
  late final String _gatwayId;
  late final String? _locationId;

  Asset({
    required String id,
    required String name,
    required String? parentId,
    required String? sensorId,
    required String sensorType,
    required String status,
    required String gatwayId,
    required String? locationId,
  })  : _id = id,
        _gatwayId = gatwayId,
        _locationId = locationId,
        _name = name,
        _parentId = parentId,
        _sensorId = sensorId,
        _sensorType = sensorType,
        _status = status;

  String get id => _id;

  String get gatwayId => _gatwayId;

  String? get locationId => _locationId;

  String get name => _name;

  String? get parentId => _parentId;

  String? get sensorId => _sensorId;

  String get sensorType => _sensorType;

  String get status => _status;

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'] as String,
      name: json['name'] as String,
      parentId: json['parentId'] as String?,
      sensorId: json['sensorId'] as String?,
      sensorType: json['sensorType'] as String,
      status: json['status'] as String,
      gatwayId: json['gatwayId'] as String,
      locationId: json['locationId'] as String?,
    );
  }
}
