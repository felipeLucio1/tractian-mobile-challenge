import 'dart:convert';

import 'package:app/model/location.dart';
import 'package:app/repository/company_repository.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart' as log;

var logger = log.Logger('');

Future<List<Location>> getCompanyLocations(String companyId) async {
  final response = await http.get(Uri.parse('$url/$companyId/locations'));

  return response.statusCode == 200
      ? listLocations(response.body)
      : throw Exception('Failed to fetch locations.');
}

List<Location> listLocations(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<Location>((json) => Location.fromJson(json)).toList();
}
