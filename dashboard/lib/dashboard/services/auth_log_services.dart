import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart' as root_bundle;

import '../model/auth_model/auth_log_model.dart';
import 'package:http/http.dart' as http;

Future<List<AuthLogModel>> readJsonAuthLog({
  required String filename,
}) async {
  final jsondata = await root_bundle.rootBundle.loadString(
    // filename,
    'Predicted Results/Auth Log/json/auth_2022_08_23__09_53_13.json',
  );
  final list = json.decode(jsondata) as List<dynamic>;

  return list.map((e) => AuthLogModel.fromJson(e)).toList();
}

class DashBoardService {
  // fetch dataset from the api
  static Future getPrevousPredictedResult({required String datasetname}) async {
    try {
      final response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/v1/$datasetname/previous/"),
      );
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

// authentication predicted data

  static Future authPredictData({required dataTosend}) async {
    try {
      final response = await http.post(
        Uri.parse(
          "http://127.0.0.1:8000/api/v1/auth/previous/",
        ),
        body: dataTosend,
      );
      final responseBody = [response.statusCode, response.body];
      log(responseBody.toString());
      return responseBody;
    } catch (e) {
      rethrow;
    }
  }
  
}
