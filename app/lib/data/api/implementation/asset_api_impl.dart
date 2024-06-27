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
  final _streamController = StreamController<List<Asset>>.broadcast();

  Stream<List<Asset>> fetchAssets(String id) async* {
    final response = await http.get(Uri.parse('$url/$id/assets'));
    List<Asset> rettrievedAssetsList = List.empty();

    response.statusCode == 200
        ? () async {
            _streamController.add(await compute(_getAssetsList, response.body));
            rettrievedAssetsList =
                _streamController.stream.single as List<Asset>;
          }
        : _streamController.addError(Exception('failed to load '));

    LoggerWrapper().logger.info(rettrievedAssetsList.toString());
    yield rettrievedAssetsList;
  }

  List<Asset> _getAssetsList(responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed.map<Asset>((json) => Asset.fromJson(json)).toList();
  }
}
