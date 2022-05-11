import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_tracker/model/profilemodel.dart';

import '../../controller/admin/readallprofilecontroller.dart';

class ViewAllProfiles extends StatelessWidget {
  const ViewAllProfiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Profiles"),
      ),
      body: GetBuilder<ReadAllProfileController>(
          init: ReadAllProfileController(),
          builder: (controller) {
            return controller.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.profiles.isEmpty
                    ? Center(
                        child: Text("No Profiles Found"),
                      )
                    : Column(
                        children: [
                          ListTile(
                            title: Text("Total Users"),
                            trailing:
                                Text(controller.profiles.length.toString()),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.profiles.length,
                              itemBuilder: (context, index) {
                                ProfileModel profile =
                                    controller.profiles[index];
                                return Card(
                                  elevation: 7,
                                  child: ListTile(
                                    title: Text(profile.username),
                                    subtitle: Text(
                                      profile.email +
                                          "\n" +
                                          "Join Date : " +
                                          profile.date,
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
