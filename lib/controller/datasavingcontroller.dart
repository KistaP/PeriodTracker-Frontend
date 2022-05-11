import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:period_tracker/model/perioddatamodel.dart';
import 'package:period_tracker/model/profilemodel.dart';
import 'package:period_tracker/utils/remoteservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../view/main_panel.dart';

class DatasavingController extends GetxController {
  late SharedPreferences preferences;

  saveProfile(ProfileModel model) async {
    preferences = await SharedPreferences.getInstance();
    String data = profileModelToJson(model);
    preferences.setString('profile', data);
    log("Data Saved");
  }

  readPerioddata(BuildContext context) async {
    ProfileModel? model = await readProfile();
    var response = await RemoteServices.readPeriodData(model!.id.toString());
    log(response);
    if (response == "false") {
      Navigator.pushNamedAndRemoveUntil(
          context, '/setuptour', (route) => false);
    } else {
      periodData = periodDataModelFromJson(response);
      await showNotification(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainPanel(),
          ),
          (route) => false);
    }
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('bell');

  showNotification(BuildContext context) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Kathmandu"));
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (value) {},
    );

    DatasavingController dsc = DatasavingController();
    PeriodDataModel? model = await dsc.readPerioddata(context);
    DateTime date = model!.lastperioddate.add(
      Duration(days: 28, hours: 7),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Hii',
      'Your period may starts from today',
      tz.TZDateTime.from(date, tz.getLocation("Asia/Kathmandu")),
      const NotificationDetails(
          android: AndroidNotificationDetails('123', 'your channel name',
              channelDescription: 'your channel description')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  late PeriodDataModel periodData;
  Future<ProfileModel?> readProfile() async {
    preferences = await SharedPreferences.getInstance();
    String data = preferences.getString('profile') ?? "";
    if (data == "") {
      return null;
    } else {
      ProfileModel model = profileModelFromJson(data);
      var response = await RemoteServices.readPeriodData(model.id.toString());
      if (response == "false") {
      } else {
        periodData = periodDataModelFromJson(response);
      }
      return model;
    }
  }

  logout() async {
    preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
