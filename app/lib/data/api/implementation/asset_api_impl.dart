import 'dart:async';
import 'dart:convert';
import 'package:app/data/api/abstract/fetch_components_api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:app/data/model/asset.dart';
import 'package:app/data/api/implementation/utils.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FetchAssetssApi)
class AssetApiImpl extends FetchAssetssApi {
  final _streamController = StreamController.broadcast();

  @override
  Stream<List<Asset>> fetchAssets(String id) async* {
    final response = await http.get(Uri.parse('$url/$id/assets'));

    response.statusCode == 200
        ? _streamController.add(compute(_getAssetsList, response.body))
            as List<Asset>
        : _streamController.addError(Exception('failed to load '));
  }

  List<Asset> _getAssetsList(responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed.map<Asset>((json) => Asset.fromJson(json)).toList();
  }
}
