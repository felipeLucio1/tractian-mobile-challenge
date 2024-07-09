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
    List<Location> retrievedLocationsList = List.empty();

    if (response.statusCode == 200) {
      retrievedLocationsList = await compute(_listLocations, response.body);
    }

    return retrievedLocationsList;
  }

  List<Location> _listLocations(String responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed.map<Location>((json) => Location.fromJson(json)).toList();
  }
}
