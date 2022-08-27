import 'dart:convert';

import 'package:flutter/services.dart' as root_bundle;

import '../model/auth_log_model.dart';

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
