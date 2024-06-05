import 'dart:convert';

import 'package:app/model/company.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const url = "https://fake-api.tractian.com";
late String companyId;

Future<List<Company>> fetchCompanies() async {
  final response = await http.get(Uri.parse("$url/companies"));

  return response.statusCode == 200
      ? compute(listCompanies, response.body)
      : throw Exception('Filed to load data!');
}

List<Company> listCompanies(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<Company>((json) => Company.fromJson(json)).toList();
}
