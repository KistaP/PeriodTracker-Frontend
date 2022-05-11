import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/controller/generatereportcontroller.dart';
import 'package:period_tracker/view/reportpage.dart';

class GenerateReportPage extends StatelessWidget {
  const GenerateReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Report"),
      ),
      body: GetBuilder<GenerateReportController>(
        init: GenerateReportController(),
        builder: (controller) {
          return controller.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: controller.symptoms.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportPage(
                              model: controller.symptoms[index],
                            ),
                          ),
                        );
                      },
                      title: Text(
                        DateFormat("yyyy MMM dd").format(
                                controller.symptoms[index].periodStartDate) +
                            "-" +
                            DateFormat("yyyy MMM dd").format(
                              controller.symptoms[index].periodEndDate,
                            ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
