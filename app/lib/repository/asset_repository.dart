import 'dart:convert';
import 'package:app/repository/company_repository.dart';
import 'package:http/http.dart' as http;
import 'package:app/model/asset.dart';

Future<List<Asset>> fetchAssets(String companyId) async {
  final response = await http.get(Uri.parse('$url/$companyId/assets'));

  return response.statusCode == 200
      ? getAssetsList(response.body)
      : throw Exception('failed to load ');
}

List<Asset> getAssetsList(responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<Asset>((json) => Asset.fromJson(json)).toList();
}
