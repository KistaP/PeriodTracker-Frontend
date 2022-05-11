import 'dart:convert';
import 'dart:developer';
import 'package:period_tracker/controller/datasavingcontroller.dart';
import 'package:get/get.dart';
import 'package:period_tracker/model/profilemodel.dart';
import 'package:period_tracker/model/perioddatamodel.dart';
import 'package:period_tracker/utils/remoteservices.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UploadPeriodDataController extends GetxController {
  bool loading = false;
  int cycleLength = 14;
  int periodLength = 4;
  DateTime lastPeriodDate = DateTime.now();
  uploadPeriodData(DateTime date) async {
    loading = true;
    update();
    DatasavingController dsc = DatasavingController();
    ProfileModel? profileModel = await dsc.readProfile();
    var response = await RemoteServices.uploadPeriodData(
      PeriodDataModel(
        id: 0,
        createddate: DateTime.now(),
        userId: profileModel!.id,
        cycleLength: cycleLength,
        periodlength: periodLength,
        lastperioddate: date,
      ),
    );

    String result = json.decode(response)['Status'];
    Fluttertoast.showToast(msg: result);
    loading = false;
    update();
  }
}
