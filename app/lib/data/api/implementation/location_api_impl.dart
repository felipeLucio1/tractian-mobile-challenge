import 'dart:async';
import 'dart:convert';
import 'package:app/data/model/location.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:app/data/api/implementation/utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationApi {
  Future<List<Location>> fetchLocations(String id) async {
    final response = await http.get(Uri.parse('$url/$id/locations'));
    final streamController = StreamController<List<Location>>.broadcast();
    List<Location> retrievedLocationsList = List.empty();

    response.statusCode == 200
        ? () async {
            streamController.add(await compute(_listLocations, response.body));
            retrievedLocationsList =
                streamController.stream.single as List<Location>;
          }
        : streamController.addError(Exception('Failed to fetch locations.'));

    return retrievedLocationsList;
  }

  List<Location> _listLocations(String responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed.map<Location>((json) => Location.fromJson(json)).toList();
  }
}
