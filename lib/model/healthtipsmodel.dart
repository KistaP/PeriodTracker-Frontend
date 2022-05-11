// To parse this JSON data, do
//
//     final healthTipsModel = healthTipsModelFromJson(jsonString);

import 'dart:convert';

HealthTipsModel singlehealthTipsModelFromJson(String str) =>
    HealthTipsModel.fromJson(json.decode(str));

String singlehealthTipsModelToJson(HealthTipsModel data) =>
    json.encode(data.toJson());

List<HealthTipsModel> healthTipsModelFromJson(String str) =>
    List<HealthTipsModel>.from(
        json.decode(str).map((x) => HealthTipsModel.fromJson(x)));

String healthTipsModelToJson(List<HealthTipsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HealthTipsModel {
  HealthTipsModel({
    required this.id,
    required this.date,
    required this.url,
  });

  int id;
  DateTime date;
  String url;

  factory HealthTipsModel.fromJson(Map<String, dynamic> json) =>
      HealthTipsModel(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "url": url,
      };
}
