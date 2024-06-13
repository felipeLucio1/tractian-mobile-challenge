import 'dart:convert';
import 'package:app/data/api/abstract/fetch_components_api.dart';
import 'package:http/http.dart' as http;
import 'package:app/data/model/asset.dart';
import 'package:app/data/api/implementation/utils.dart';

class AssetApiImpl extends FetchComponentsApi {
  @override
  Stream<List<Asset>> fetch(String id) async* {
    final response = await http.get(Uri.parse('$url/$id/assets'));

    yield response.statusCode == 200
        ? getAssetsList(response.body)
        : throw Exception('failed to load ');
  }

  List<Asset> getAssetsList(responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed.map<Asset>((json) => Asset.fromJson(json)).toList();
  }
}
