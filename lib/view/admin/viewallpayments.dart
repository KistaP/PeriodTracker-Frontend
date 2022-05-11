import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/controller/admin/readallpaymentcontroller.dart';
import 'package:period_tracker/model/paymentreadingmodel.dart';
import 'package:period_tracker/model/profilemodel.dart';

import '../../controller/admin/readallprofilecontroller.dart';

class ViewAllPayments extends StatelessWidget {
  const ViewAllPayments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Payments"),
      ),
      body: GetBuilder<ReadAllPaymentController>(
          init: ReadAllPaymentController(),
          builder: (controller) {
            return controller.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.payments.isEmpty
                    ? Center(
                        child: Text("No Profiles Found"),
                      )
                    : Column(
                        children: [
                          ListTile(
                            title: Text("Total Users"),
                            trailing:
                                Text(controller.payments.length.toString()),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.payments.length,
                              itemBuilder: (context, index) {
                                PaymentReadingModel model =
                                    controller.payments[index];
                                return Card(
                                  elevation: 7,
                                  child: ListTile(
                                    title: Text(model.username),
                                    subtitle: Text(
                                      model.email +
                                          "\n" +
                                          "Join Date : " +
                                          DateFormat("yyyy MMM dd")
                                              .format(model.createDate),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
          }),
    );
  }
}
