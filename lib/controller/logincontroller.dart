import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:period_tracker/controller/datasavingcontroller.dart';
import 'package:period_tracker/model/profilemodel.dart';
import 'package:period_tracker/model/perioddatamodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:period_tracker/utils/remoteservices.dart';

import '../view/main_panel.dart';

class LoginController extends GetxController {
  bool loading = false;

  login(String email, String password, BuildContext context) async {
    loading = true;
    update();
    var response = await RemoteServices.login(email, password);
    Map<String, dynamic> data = json.decode(response);

    if (data.containsKey("state")) {
      Fluttertoast.showToast(msg: data['status']);
    } else {
      ProfileModel profile = profileModelFromJson(response);
      DatasavingController datasavingController = DatasavingController();
      datasavingController.saveProfile(profile);
      var response2 =
          await RemoteServices.readPeriodData(profile.id.toString());
      if (response2.contains("false")) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/setuptour', (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPanel(),
            ),
            (route) => false);
      }
      Fluttertoast.showToast(msg: "Login Successful");
    }
    loading = false;
    update();
  }
}
