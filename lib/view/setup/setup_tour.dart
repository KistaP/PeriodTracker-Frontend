import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_tracker/controller/datasavingcontroller.dart';
import 'package:period_tracker/model/profilemodel.dart';
import 'package:period_tracker/view/setup/periodlength.dart';

import '../../controller/uplaodperioddatacontroller.dart';
import 'cycle_length_screen.dart';
import 'last_period_picker.dart';

class SetupTour extends StatefulWidget {
  const SetupTour({Key? key}) : super(key: key);

  @override
  _SetupTourState createState() => _SetupTourState();
}

class _SetupTourState extends State<SetupTour> {
  PageController pageController = PageController();
  UploadPeriodDataController updc = Get.put(UploadPeriodDataController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UploadPeriodDataController>(
        init: UploadPeriodDataController(),
        builder: (controller) {
          return GetBuilder<DatasavingController>(
              init: DatasavingController(),
              builder: (dsc) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Setup Page"),
                  ),
                  body: FutureBuilder<ProfileModel?>(
                      future: dsc.readProfile(),
                      builder: (context, snapshot) {
                        return snapshot.data == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : PageView(
                                controller: pageController,
                                children: [
                                  CycleLengthPage(
                                    controller: controller,
                                    profile: snapshot.data!,
                                  ),
                                  PeriodLengthPage(
                                    controller: controller,
                                  ),
                                  LastPeriodPickerPage(
                                    controller: controller,
                                  ),
                                ],
                              );
                      }),
                  bottomNavigationBar: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          pageController.previousPage(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.ease,
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          pageController.nextPage(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.ease,
                          );
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
