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
  late String companyId;
  final streamController = StreamController<List<Company>>.broadcast();

  @override
  Stream<List<Company>> fetchCompany() async* {
    final response = await http.get(Uri.parse("$url/companies"));

    response.statusCode == 200
        ? streamController
            .add(compute(listCompanies, response.body) as List<Company>)
        : streamController.addError(Exception('Failed to load data'));
  }

  List<Company> listCompanies(String responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed.map<Company>((json) => Company.fromJson(json)).toList();
  }
}
