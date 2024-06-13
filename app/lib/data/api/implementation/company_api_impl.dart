import 'dart:convert';
import 'package:app/data/api/abstract/fetch_user_companies_api.dart';
import 'package:app/data/model/company.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:app/data/api/implementation/utils.dart';

class CompanyApiImpl extends FetchUserCompaniesApi {
  late String companyId;

  @override
  Stream<List<Company>> fetchCompany() async* {
    final response = await http.get(Uri.parse("$url/companies"));

    yield response.statusCode == 200
        ? compute(listCompanies, response.body) as List<Company>
        : throw Exception('Filed to load data!');
  }

  List<Company> listCompanies(String responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed.map<Company>((json) => Company.fromJson(json)).toList();
  }
}
