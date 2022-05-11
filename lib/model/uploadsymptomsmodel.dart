// To parse this JSON data, do
//
//     final uploadSymptomsModel = uploadSymptomsModelFromJson(jsonString);

import 'dart:convert';

UploadSymptomsModel singleuploadSymptomsModelFromJson(String str) =>
    UploadSymptomsModel.fromJson(json.decode(str));

String singleuploadSymptomsModelToJson(UploadSymptomsModel data) =>
    json.encode(data.toJson());

List<UploadSymptomsModel> uploadSymptomsModelFromJson(String str) =>
    List<UploadSymptomsModel>.from(
        json.decode(str).map((x) => UploadSymptomsModel.fromJson(x)));

String uploadSymptomsModelToJson(List<UploadSymptomsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UploadSymptomsModel {
  UploadSymptomsModel({
    required this.id,
    required this.userId,
    required this.updateDate,
    required this.symptoms,
    required this.periodStartDate,
    required this.periodEndDate,
  });

  int id;
  int userId;
  DateTime updateDate;
  String symptoms;
  DateTime periodStartDate;
  DateTime periodEndDate;

  factory UploadSymptomsModel.fromJson(Map<String, dynamic> json) =>
      UploadSymptomsModel(
        id: json["id"],
        userId: json["user_id"],
        updateDate: DateTime.parse(json["update_date"]),
        symptoms: json["symptoms"],
        periodStartDate: DateTime.parse(json["period_start_date"]),
        periodEndDate: DateTime.parse(json["period_end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "update_date":
            "${updateDate.year.toString().padLeft(4, '0')}-${updateDate.month.toString().padLeft(2, '0')}-${updateDate.day.toString().padLeft(2, '0')}",
        "symptoms": symptoms,
        "period_start_date":
            "${periodStartDate.year.toString().padLeft(4, '0')}-${periodStartDate.month.toString().padLeft(2, '0')}-${periodStartDate.day.toString().padLeft(2, '0')}",
        "period_end_date":
            "${periodEndDate.year.toString().padLeft(4, '0')}-${periodEndDate.month.toString().padLeft(2, '0')}-${periodEndDate.day.toString().padLeft(2, '0')}",
      };
}
