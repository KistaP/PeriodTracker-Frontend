import 'dart:convert';
import 'dart:developer';
import 'package:period_tracker/model/healthtipsmodel.dart';
import 'package:period_tracker/model/profilemodel.dart';
import 'package:period_tracker/model/perioddatamodel.dart';
import 'package:dio/dio.dart';
import 'package:period_tracker/model/symptomsmodel.dart';
import 'package:period_tracker/model/uploadsymptomsmodel.dart';

class RemoteServices {
  // to get ip address run 'ípconfig' in cmd or terminal
  // copy ipv4
  static String initialUrl = "http://192.168.1.75/periodtracker";

  // Method for signup(creating account)
  static Future<String> signup(ProfileModel model) async {
    String url = initialUrl + '/signup.php';
    FormData data = FormData.fromMap(
      json.decode(
        profileModelToJson(model),
      ),
    );
    var response = await Dio().post(url, data: data);
    return response.data;
  }

//Method for Login (requries email and password)
  static Future<String> login(String email, String password) async {
    var url = initialUrl + '/login.php?email=$email&password=$password';
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> unlockPremium(int id) async {
    var url = initialUrl + '/updatepremium.php?id=$id';
    var response = await Dio().get(url);
    return response.data;
  }

// unlock premium
  static Future<String> savePayment(DateTime date, double amount,
      String description, int userid, String khaltiNo) async {
    var url = initialUrl + '/updatepremium.php';
    var response = await Dio().post(
      url,
      data: FormData.fromMap(
        {
          "date": date,
          "amount": amount,
          "description": description,
          "customer_id": userid,
          "khalti_no": khaltiNo,
        },
      ),
    );
    return response.data;
  }

// method for uploading previous period data after signing up
  static Future<String> uploadPeriodData(PeriodDataModel model) async {
    String url = initialUrl + '/perioddata/createperioddata.php';
    FormData data = FormData.fromMap(
      json.decode(
        periodDataModelToJson(model),
      ),
    );
    var response = await Dio().post(url, data: data);
    log(response.data);
    return response.data;
  }

// reading data for displaying in calender
  static Future<String> readPeriodData(String userId) async {
    String url = initialUrl + "/perioddata/readperioddata.php?user_id=$userId";
    var response = await Dio().get(url);
    return response.data;
  }

// upload link in news page
  static Future<String> uploadHealthTips(HealthTipsModel model) async {
    String url = initialUrl + '/healthtips/createhealthtips.php';
    FormData data = FormData.fromMap(
      json.decode(
        singlehealthTipsModelToJson(model),
      ),
    );
    var response = await Dio().post(url, data: data);
    log(response.data);
    return response.data;
  }

  static Future<String> readHealthTips() async {
    String url = initialUrl + "/healthtips/readhealthtips.php";
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> uploadHealthLinks(String link) async {
    String url = initialUrl + "/healthtips/createhealthtipslink.php";
    var response = await Dio().post(url,
        data: FormData.fromMap({
          "link": link,
        }));
    return response.data;
  }

  static Future<String> uploadMySymptoms(UploadSymptomsModel model) async {
    String url = initialUrl + "/symptoms/createsymptoms.php";
    var response = await Dio().post(
      url,
      data: FormData.fromMap(
        json.decode(
          singleuploadSymptomsModelToJson(model),
        ),
      ),
    );
    log(response.data);
    return response.data;
  }

// reading profile either for admin or user
  static Future<String> readAllProfiles() async {
    String url = initialUrl + "/profile/profile.php";
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> readAllPayments() async {
    String url = initialUrl + "/payment/readpayment.php";
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> readMyReports(String id) async {
    String url = initialUrl + "/symptoms/readsymptoms.php?user_id=$id";
    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static Future<String> changePassword(
      String email, String currentPassword, String newPassword) async {
    String url = '$initialUrl/changepassword.php';

    var response = await Dio().post(
      url,
      data: FormData.fromMap({
        "email": email,
        "password": currentPassword,
        "newpassword": newPassword,
      }),
    );
    log(response.data);
    return response.data;
  }

  static Future<String> requestPasswordChange({
    required String email,
  }) async {
    log("<==Changing the password==>");
    String url = '$initialUrl/passwordreset/requestreset.php?email=$email';

    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static Future<String> submitVerificationCode(
      String code, String email) async {
    log("<==Submitting Verification Code==>");
    String url =
        '$initialUrl/passwordreset/verifyCode.php?email=$email&token=$code';
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> resetPassword(
      String token, String email, String password) async {
    log("<==Resetting the password==>");
    String url = '$initialUrl/passwordreset/resetpassword.php';

    var response = await Dio().post(
      url,
      data: FormData.fromMap({
        "email": email,
        "token": token,
        "password": password,
      }),
    );
    log(response.data);
    return response.data;
  }
}
