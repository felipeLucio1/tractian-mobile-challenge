import 'dart:async';
import 'dart:convert';
import 'package:app/data/api/abstract/fetch_components_api.dart';
import 'package:app/data/model/company.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:app/data/api/implementation/utils.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FetchUserCompaniesApi)
class CompanyApiImpl extends FetchUserCompaniesApi {
  final _streamController = StreamController<List<Company>>.broadcast();

  @override
  Stream<List<Company>> fetchCompany() async* {
    final response = await http.get(Uri.parse("$url/companies"));

    response.statusCode == 200
        ? _streamController
            .add(compute(_listCompanies, response.body) as List<Company>)
        : _streamController.addError(Exception('Failed to load data'));
  }

  List<Company> _listCompanies(String responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed.map<Company>((json) => Company.fromJson(json)).toList();
  }
}
