class Asset {
  final String id;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String sensorType;
  final String status;
  final String gatwayId;
  final String? locationId;

  const Asset({
    required this.id,
    required this.name,
    this.parentId,
    this.sensorId,
    required this.sensorType,
    required this.status,
    required this.gatwayId,
    this.locationId,
  });

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
