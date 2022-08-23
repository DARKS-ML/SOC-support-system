import 'dart:convert';

import '../Model/auth_log_model.dart';
import 'package:flutter/services.dart' as rootBundle;

Future<List<AuthLogModel>> readJsonAuthLog() async {
  final jsondata = await rootBundle.rootBundle.loadString('jsonfile/auth.json');
  final list = json.decode(jsondata) as List<dynamic>;

  return list.map((e) => AuthLogModel.fromJson(e)).toList();
}
