import 'dart:async';
import 'dart:convert';
import 'package:app/data/model/company.dart';
import 'package:app/di/dependencies_register.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:app/data/api/implementation/utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompanyApi {
  final _streamController = StreamController<List<Company>>();

  Future<List<Company>> fetchCompany() async {
    final response = await http.get(Uri.parse("$url/companies"));
    List<Company> retrievedCompaniesList = List.empty();

    LoggerWrapper().logger.info(response.body);

    if (response.statusCode == 200) {
      retrievedCompaniesList = await compute(_listCompanies, response.body);
    } else {
      _streamController.addError(Exception('Failed to load data'));
    }

    return retrievedCompaniesList;
  }

  List<Company> _listCompanies(String responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed.map<Company>((json) => Company.fromJson(json)).toList();
  }
}
