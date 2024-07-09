import 'dart:async';
import 'dart:convert';
import 'package:app/di/dependencies_register.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:app/data/model/asset.dart';
import 'package:app/data/api/implementation/utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class AssetApi {
  Future<List<Asset>> fetchAssets(String id) async {
    final response = await http.get(Uri.parse('$url/$id/assets'));
    List<Asset> rettrievedAssetsList = List<Asset>.empty();

    if (response.statusCode == 200) {
      rettrievedAssetsList = await compute(_getAssetsList, response.body);
    }

    LoggerWrapper().logger.info(rettrievedAssetsList.toString());
    return rettrievedAssetsList;
  }

  List<Asset> _getAssetsList(responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    final list = parsed.map<Asset>((json) => Asset.fromJson(json)).toList();
    return list;
  }
}
