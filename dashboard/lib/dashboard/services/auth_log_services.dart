import 'dart:convert';

import '../Model/auth_log_model.dart';
import 'package:flutter/services.dart' as root_bundle;

Future<List<AuthLogModel>> readJsonAuthLog() async {
  final jsondata = await root_bundle.rootBundle.loadString(
    'Predicted Results/Auth Log/json/auth_2022_08_23__09_53_13.json',
  );
  final list = json.decode(jsondata) as List<dynamic>;

  return list.map((e) => AuthLogModel.fromJson(e)).toList();
}
