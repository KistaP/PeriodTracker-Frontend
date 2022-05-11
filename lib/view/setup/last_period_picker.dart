import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:period_tracker/controller/uplaodperioddatacontroller.dart';
import 'package:period_tracker/view/main_panel.dart';

import 'package:table_calendar/table_calendar.dart';

class LastPeriodPickerPage extends StatefulWidget {
  LastPeriodPickerPage({Key? key, required this.controller}) : super(key: key);
  final UploadPeriodDataController controller;

  @override
  State<LastPeriodPickerPage> createState() => _LastPeriodPickerPageState();
}

class _LastPeriodPickerPageState extends State<LastPeriodPickerPage> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "When did you have your period last",
            style: TextStyle(
              color: Colors.brown,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            currentDay: date,
            focusedDay: DateTime.now(),
            onDaySelected: (date1, date2) {
              setState(() {
                date = date2;
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              await widget.controller.uploadPeriodData(date);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPanel(),
                  ),
                  (route) => false);
            },
            child: Text("confirm"),
          ),
        ],
      ),
    );
  }
}
