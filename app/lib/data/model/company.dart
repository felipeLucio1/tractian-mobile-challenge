import 'package:injectable/injectable.dart';

@injectable
class Company {
  late final String _id;
  late final String _name;

  Company({required String id, required String name})
      : _name = name,
        _id = id;

  String get id => _id;

  String get companyName => _name;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(id: json['id'] as String, name: json['name'] as String);
  }
}
