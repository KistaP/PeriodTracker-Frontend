import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:period_tracker/model/profilemodel.dart';
import 'package:period_tracker/model/perioddatamodel.dart';
import '../utils/remoteservices.dart';

class SignupController extends GetxController {
  bool signuploading = false;
  signup(ProfileModel model, BuildContext context) async {
    signuploading = true;
    update();
    var response = await RemoteServices.signup(model);
    log(response);
    String result = json.decode(response)['status'];
    Fluttertoast.showToast(msg: result);
    if (result == "You have created your account") {
      Navigator.pop(context);
    }
    signuploading = false;
    update();
  }
}
