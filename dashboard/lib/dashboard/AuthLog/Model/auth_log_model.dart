// To parse this JSON data, do
//
//     final authLogModel = authLogModelFromJson(jsonString);

import 'dart:convert';

List<AuthLogModel> authLogModelFromJson(String str) => List<AuthLogModel>.from(
    json.decode(str).map((x) => AuthLogModel.fromJson(x)));

String authLogModelToJson(List<AuthLogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuthLogModel {
  AuthLogModel({
    required this.date,
    required this.time,
    required this.ip,
    required this.process,
    required this.event,
    this.distance,
    this.label,
    this.modZscore,
  });

  String date;
  String time;
  String ip;
  String process;
  String event;
  double? distance;
  int? label;
  double? modZscore;

  factory AuthLogModel.fromJson(Map<String, dynamic> json) => AuthLogModel(
        date: json["date"],
        time: json["time"],
        ip: json["ip"],
        process: json["process"],
        event: json["event"],
        distance: double.parse(json["distance"]),
        label: int.parse(json["label"]),
        modZscore: double.parse(json["mod_zscore"]),
        // modZscore: json["mod_zscore"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "time": time,
        "ip": ip,
        "process": process,
        "event": event,
        "distance": distance,
        "label": label,
        "mod_zscore": modZscore,
      };
}
