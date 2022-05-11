import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_tracker/controller/uplaodperioddatacontroller.dart';
import 'package:period_tracker/model/profilemodel.dart';

class CycleLengthPage extends StatefulWidget {
  CycleLengthPage({Key? key, required this.controller, required this.profile})
      : super(key: key);
  final UploadPeriodDataController controller;
  final ProfileModel profile;
  @override
  State<CycleLengthPage> createState() => _CycleLengthPageState();
}

class _CycleLengthPageState extends State<CycleLengthPage> {
  int minimum = 14;
  int maximum = 40;

  int current = 14;

  increase(UploadPeriodDataController controller) {
    if (current < 40) {
      current++;
      widget.controller.cycleLength = current;
      setState(() {});
    }
  }

  decrease(UploadPeriodDataController controller) {
    if (current > minimum) {
      current--;
      widget.controller.cycleLength = current;
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
                    "Ok ${widget.profile.username}, let's get started",
                    style: const TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    "Your cycle length",
                    style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
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
                        current.toString(),
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
