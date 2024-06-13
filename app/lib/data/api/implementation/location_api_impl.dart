import 'dart:async';
import 'dart:convert';
import 'package:app/data/api/abstract/fetch_components_api.dart';
import 'package:app/data/model/location.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:app/data/api/implementation/utils.dart';

class LocationApiImpl extends FetchLocationsApi {
  @override
  Stream<List<Location>> fetchLocations(String id) async* {
    final response = await http.get(Uri.parse('$url/$id/locations'));
    final streamController = StreamController.broadcast();

    response.statusCode == 200
        ? streamController
                .add(compute(listLocations, response.body) as List<Location>)
            as List<Location>
        : streamController.addError(Exception('Failed to fetch locations.'));
  }

  List<Location> listLocations(String responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed.map<Location>((json) => Location.fromJson(json)).toList();
  }
}
