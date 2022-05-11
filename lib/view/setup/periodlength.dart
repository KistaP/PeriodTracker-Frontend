import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_tracker/controller/uplaodperioddatacontroller.dart';

class PeriodLengthPage extends StatefulWidget {
  PeriodLengthPage({Key? key, required this.controller}) : super(key: key);
  final UploadPeriodDataController controller;
  @override
  State<PeriodLengthPage> createState() => _PeriodLengthPageState();
}

class _PeriodLengthPageState extends State<PeriodLengthPage> {
  int minimum = 3;
  int maximum = 15;
  int current = 3;

  increase(UploadPeriodDataController controller) {
    if (current < 15) {
      current++;
      widget.controller.periodLength = current;
      setState(() {});
    }
  }

  decrease(UploadPeriodDataController controller) {
    if (current > minimum) {
      current--;
      widget.controller.periodLength = current;
      setState(() {});
    }
  }

  UploadPeriodDataController updc = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UploadPeriodDataController>(
          init: updc,
          builder: (controller) {
            return Container(
              width: Get.width,
              height: Get.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "How long does your period last",
                    style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Your period length",
                    style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          decrease(controller);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                      Text(
                        "$current",
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          increase(controller);
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
