import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/model/symptomsmodel.dart';
import 'package:period_tracker/model/uploadsymptomsmodel.dart';

class ReportPage extends StatelessWidget {
  ReportPage({Key? key, required this.model}) : super(key: key);
  final UploadSymptomsModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(height: 5),
            Text(
              "Period Start Date :    " +
                  DateFormat("yyyy MMMM dd, EEE").format(
                    model.periodStartDate,
                  ),
            ),
            SizedBox(height: 5),
            Text(
              "Period End Date :      " +
                  DateFormat("yyyy MMMM dd, EEE").format(
                    model.periodEndDate,
                  ),
            ),
            Container(
              child: Text(
                "Fertile Days:               " +
                    getFertileDays(model.periodStartDate).toString(),
              ),
            ),
            Text(
              "Possible Ovulation:   " +
                  DateFormat("yyyy MMMM dd, EEE").format(
                    getOvulationDate(
                      model.periodEndDate,
                    ),
                  ),
            ),
            for (var item in symptomModelFromJson(model.symptoms))
              ListTile(
                leading: Image.asset(item.image, height: 25, width: 22),
                title: Text(item.name),
                trailing: RatingStars(
                  value: item.rating,
                  starBuilder: (index, color) => Icon(
                    Icons.star,
                    color: color,
                  ),
                  starCount: 5,
                  starSize: 20,
                  valueLabelColor: const Color(0xff9b9b9b),
                  valueLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0,
                  ),
                  valueLabelRadius: 10,
                  maxValue: 5,
                  starSpacing: 2,
                  maxValueVisibility: false,
                  valueLabelVisibility: false,
                  animationDuration: Duration(milliseconds: 1000),
                  valueLabelPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  valueLabelMargin: const EdgeInsets.only(right: 8),
                  starOffColor: const Color(0xffe7e8ea),
                  starColor: Colors.yellow,
                ),
              ),
          ],
        ),
      ),
    );
  }

  DateTime getOvulationDate(DateTime date) {
    return date.add(const Duration(days: 10));
  }

  List<int> fertileDates = <int>[];
  List<int> getFertileDays(DateTime enddate) {
    List<DateTime> ovulationPeriod = <DateTime>[];
    DateTime ovulationBegin = enddate.add(
      const Duration(days: 4),
    );
    for (int i = 0; i < 6; i++) {
      ovulationPeriod.add(ovulationBegin.add(Duration(days: i)));
    }
    fertileDates.clear();
    for (var item in ovulationPeriod) {
      fertileDates.add(item.day);
    }
    return fertileDates;
  }
}
