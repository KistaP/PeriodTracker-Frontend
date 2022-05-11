// To parse this JSON data, do
//
//     final symptomModel = symptomModelFromJson(jsonString);

import 'dart:convert';

SymptomModel singleSymptomModelFromJson(String str) =>
    SymptomModel.fromJson(json.decode(str));

String singleSymptomModelToJson(SymptomModel data) =>
    json.encode(data.toJson());

List<SymptomModel> symptomModelFromJson(String str) => List<SymptomModel>.from(
    json.decode(str).map((x) => SymptomModel.fromJson(x)));

String symptomModelToJson(List<SymptomModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SymptomModel {
  SymptomModel({
    required this.image,
    required this.name,
    required this.rating,
  });

  String image;
  String name;
  double rating;

  factory SymptomModel.fromJson(Map<String, dynamic> json) => SymptomModel(
        image: json["image"],
        name: json["name"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "rating": rating,
      };
}
