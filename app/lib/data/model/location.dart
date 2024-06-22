import 'package:injectable/injectable.dart';

@injectable
class Location {
  late final String _id;
  late final String _name;
  late final String? _parentId;

  Location(
      {required String id, required String name, required String? parentId})
      : _id = id,
        _name = name,
        _parentId = parentId;

  String get id => _id;

  String get name => _name;

  String? get parentId => _parentId;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        id: json['id'] as String,
        name: json['name'] as String,
        parentId: json['parentId'] as String?);
  }
}
