// To parse required this JSON data, do
//
//     final periodDataModel = periodDataModelFromJson(jsonString);

import 'dart:convert';

PeriodDataModel periodDataModelFromJson(String str) =>
    PeriodDataModel.fromJson(json.decode(str));

String periodDataModelToJson(PeriodDataModel data) =>
    json.encode(data.toJson());

class PeriodDataModel {
  PeriodDataModel({
    required this.id,
    required this.createddate,
    required this.userId,
    required this.cycleLength,
    required this.periodlength,
    required this.lastperioddate,
  });

  int id;
  DateTime createddate;
  int userId;
  int cycleLength;
  int periodlength;
  DateTime lastperioddate;

  factory PeriodDataModel.fromJson(Map<String, dynamic> json) =>
      PeriodDataModel(
        id: json["id"],
        createddate: DateTime.parse(json["createddate"]),
        userId: json["user_id"],
        cycleLength: json["cycle_length"],
        periodlength: json["periodlength"],
        lastperioddate: DateTime.parse(json["lastperioddate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createddate":
            "${createddate.year.toString().padLeft(4, '0')}-${createddate.month.toString().padLeft(2, '0')}-${createddate.day.toString().padLeft(2, '0')}",
        "user_id": userId,
        "cycle_length": cycleLength,
        "periodlength": periodlength,
        "lastperioddate":
            "${lastperioddate.year.toString().padLeft(4, '0')}-${lastperioddate.month.toString().padLeft(2, '0')}-${lastperioddate.day.toString().padLeft(2, '0')}",
      };
}
