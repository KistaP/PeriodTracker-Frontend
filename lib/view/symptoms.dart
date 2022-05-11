import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:period_tracker/controller/homepagecontroller.dart';
import 'package:period_tracker/model/symptomsmodel.dart';
import 'package:period_tracker/model/uploadsymptomsmodel.dart';
import 'package:period_tracker/utils/constants.dart';
import 'package:period_tracker/utils/remoteservices.dart';

class SymptomsTracker extends StatefulWidget {
  const SymptomsTracker({Key? key}) : super(key: key);

  @override
  State<SymptomsTracker> createState() => _SymptomsTrackerState();
}

class _SymptomsTrackerState extends State<SymptomsTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Symptoms"),
      ),
      // bottomNavigationBar:
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: symptoms.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading:
                      Image.asset(symptoms[index].image, height: 25, width: 22),
                  title: Text(symptoms[index].name),
                  trailing: RatingStars(
                    value: symptoms[index].rating,
                    onValueChanged: (v) {
                      //
                      symptoms[index].rating = v;
                      setState(() {});
                    },
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
                        fontSize: 12.0),
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
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              HomepageController homepageController = HomepageController();
              RemoteServices.uploadMySymptoms(
                UploadSymptomsModel(
                  id: 0,
                  userId: 0,
                  updateDate: DateTime.now(),
                  symptoms: symptomModelToJson(symptoms),
                  periodStartDate: homepageController.getStartDate(),
                  periodEndDate: homepageController.getEndDate(),
                ),
              );
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
