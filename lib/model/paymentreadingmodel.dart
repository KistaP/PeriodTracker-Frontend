import 'dart:convert';

List<PaymentReadingModel> paymentReadingModelFromJson(String str) =>
    List<PaymentReadingModel>.from(
        json.decode(str).map((x) => PaymentReadingModel.fromJson(x)));

String paymentReadingModelToJson(List<PaymentReadingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentReadingModel {
  PaymentReadingModel({
    required this.id,
    required this.date,
    required this.amount,
    required this.description,
    required this.customerid,
    required this.khaltino,
    required this.username,
    required this.email,
    required this.createDate,
  });

  int id;
  DateTime date;
  String amount;
  String description;
  int customerid;
  String khaltino;
  String username;
  String email;
  DateTime createDate;

  factory PaymentReadingModel.fromJson(Map<String, dynamic> json) =>
      PaymentReadingModel(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        amount: json["amount"],
        description: json["description"],
        customerid: json["customerid"],
        khaltino: json["khaltino"],
        username: json["username"],
        email: json["email"],
        createDate: DateTime.parse(json["createDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "description": description,
        "customerid": customerid,
        "khaltino": khaltino,
        "username": username,
        "email": email,
        "createDate":
            "${createDate.year.toString().padLeft(4, '0')}-${createDate.month.toString().padLeft(2, '0')}-${createDate.day.toString().padLeft(2, '0')}",
      };
}
