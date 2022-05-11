import 'package:get/get.dart';
import 'package:period_tracker/controller/datasavingcontroller.dart';
import 'package:period_tracker/model/perioddatamodel.dart';
import 'package:period_tracker/model/profilemodel.dart';
import 'package:period_tracker/utils/remoteservices.dart';

class HomepageController extends GetxController {
  PeriodDataModel? model;
  DateTime activeDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    readPeriodData();
  }

  bool loading = false;

  readPeriodData() async {
    loading = true;
    update();
    DatasavingController datasavingController = DatasavingController();
    ProfileModel? profile = await datasavingController.readProfile();
    var response2 = await RemoteServices.readPeriodData(profile!.id.toString());
    model = periodDataModelFromJson(response2);
    await changeActiveDate(DateTime.now());
    loading = false;
    update();
  }

  changeActiveDate(DateTime date) {
    activeDate = date;
    getFertileDays();
    update();
  }

  // for the period duration
  DateTime getStartDate() {
    DateTime date = DateTime(
      activeDate.year,
      activeDate.month,
      model!.lastperioddate.day,
    );
    return date;
  }

  DateTime getEndDate() {
    return getStartDate().add(
      Duration(days: model!.periodlength - 1),
    );
  }

  DateTime getOvulationDate() {
    return getEndDate().add(const Duration(days: 10));
  }

  List<int> fertileDates = <int>[];
  List<int> getFertileDays() {
    List<DateTime> ovulationPeriod = <DateTime>[];
    DateTime ovulationBegin = getEndDate().add(
      const Duration(days: 4),
    );
    for (int i = 0; i < 6; i++) {
      ovulationPeriod.add(ovulationBegin.add(Duration(days: i)));
    }
    fertileDates.clear();
    for (var item in ovulationPeriod) {
      fertileDates.add(item.day);
    }
    update();
    return fertileDates;
  }
}

extension Clear on DateTime {
  DateTime clear() {
    DateTime date = DateTime(year, month, day);
    return date;
  }
}
