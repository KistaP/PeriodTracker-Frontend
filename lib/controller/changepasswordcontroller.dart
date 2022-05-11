import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:period_tracker/utils/remoteservices.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/profilemodel.dart';
import 'logincontroller.dart';

class ChangePasswordController extends GetxController {
  bool isLoading = false;
// SMTP is being used while sending email
  changePassword(BuildContext context, String email, String currentPassword,
      String newPassword) async {
    isLoading = true;
    update();
    var response = await RemoteServices.changePassword(
        email, currentPassword, newPassword);
    // log(response);
    if (response.contains('status')) {
      Fluttertoast.showToast(msg: "The Email or password did not match");
      log("The password didn't match");
    } else {
      ProfileModel model = profileModelFromJson(response);
      log(response);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('profileKey', profileModelToJson(model));
      Fluttertoast.showToast(msg: "Password has been changed");
      log("Password has been changed");
    }

    isLoading = false;
    update();
  }

  bool currentPasswordVisible = true;
  bool newPasswordVisible = true;
  bool newPasswordConfirmPassword = true;
  toggleCurrentPasswordVisible() {
    currentPasswordVisible = !currentPasswordVisible;
    update();
  }

  toggleNewPasswordVisible() {
    newPasswordVisible = !newPasswordVisible;
    update();
  }

  toggleNewPasswordConfirmVisible() {
    newPasswordConfirmPassword = !newPasswordConfirmPassword;
    update();
  }
}
