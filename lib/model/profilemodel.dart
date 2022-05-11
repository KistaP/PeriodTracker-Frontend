// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

List<ProfileModel> profilesModelFromJson(String str) => List<ProfileModel>.from(
    json.decode(str).map((x) => ProfileModel.fromJson(x)));

String profilesModelToJson(List<ProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.id,
    required this.date,
    required this.username,
    required this.password,
    required this.notificationid,
    required this.email,
    this.premium = 0,
  });

  int id;
  String date;
  String username;
  String password;
  String notificationid;
  String email;
  int premium;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"] ?? 0,
        date: json["date"],
        username: json["username"],
        password: json["password"],
        notificationid: json["notificationid"],
        email: json["email"],
        premium: json['premium'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "username": username,
        "password": password,
        "notificationid": notificationid,
        "email": email,
        "premium": premium,
      };
}
