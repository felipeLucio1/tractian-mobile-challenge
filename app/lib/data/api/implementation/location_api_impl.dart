import 'dart:convert';
import 'package:app/data/api/abstract/fetch_components_api.dart';
import 'package:app/data/model/location.dart';
import 'package:http/http.dart' as http;
import 'package:app/data/api/implementation/utils.dart';

class LocationApiImpl extends FetchComponentsApi {
  @override
  Stream<List<Location>> fetch(String id) async* {
    final response = await http.get(Uri.parse('$url/$id/locations'));

    yield response.statusCode == 200
        ? listLocations(response.body)
        : throw Exception('Failed to fetch locations.');
  }

  List<Location> listLocations(String responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed.map<Location>((json) => Location.fromJson(json)).toList();
  }
}
