import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:period_tracker/const.dart';
import 'package:period_tracker/controller/datasavingcontroller.dart';
import 'package:period_tracker/controller/logincontroller.dart';
import 'package:period_tracker/model/profilemodel.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({Key? key}) : super(key: key);
  DatasavingController dsc = DatasavingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: linearGradient,
          ),
          child: Column(
            children: [
              FutureBuilder<ProfileModel?>(
                future: dsc.readProfile(),
                builder: (context, snapshot) {
                  return snapshot.data == null
                      ? Container()
                      : Column(
                          children: [
                            Card(
                              child: SizedBox(
                                width: Get.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "My Profile",
                                        style: TextStyle(fontSize: 23),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Username : ${snapshot.data!.username}",
                                        style: style,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Email : ${snapshot.data!.email}",
                                        style: style,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(snapshot.data!.premium == 1
                                          ? "Premium User"
                                          : ""),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            snapshot.data!.email == "kistapoudel621@gmail.com"
                                ? ListTile(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/admin');
                                    },
                                    visualDensity: VisualDensity.compact,
                                    leading: const Icon(Icons.dashboard),
                                    title: const Text("Admin Panel"),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                  )
                                : Container(),
                          ],
                        );
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/myreport');
                },
                visualDensity: VisualDensity.compact,
                leading: const Icon(Icons.summarize),
                title: const Text("My Report"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                onTap: () {
                  final config = PaymentConfig(
                    amount: 10000, // Amount should be in paisa
                    productIdentity: 'dell-g5-g5510-2021',
                    productName: 'Dell G5 G5510 2021',
                    productUrl: 'https://www.khalti.com/#/bazaar',
                  );
                  KhaltiScope.of(context).pay(
                    config: config,
                    preferences: [
                      PaymentPreference.khalti,
                      PaymentPreference.connectIPS,
                      PaymentPreference.eBanking,
                      PaymentPreference.sct,
                    ],
                    onSuccess: (onSuccess) {
                      Fluttertoast.showToast(msg: "Payment Success");
                    },
                    onFailure: (onFailure) {
                      Fluttertoast.showToast(msg: onFailure.message);
                    },
                    onCancel: () {
                      Fluttertoast.showToast(msg: "Payment Canelled");
                    },
                  );
                },
                visualDensity: VisualDensity.compact,
                leading: const Icon(Icons.summarize),
                title: const Text("Buy Premium Features"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              const Spacer(),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/changepassword');
                },
                visualDensity: VisualDensity.compact,
                leading: const Icon(Icons.password),
                title: const Text("Change Password"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/forgotpassword');
                },
                visualDensity: VisualDensity.compact,
                leading: const Icon(Icons.dashboard),
                title: const Text("Forgot Password"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Attention"),
                        content:
                            const Text("Are you sure you want to logout ?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              DatasavingController dsc = DatasavingController();
                              dsc.logout();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/splash', (route) => false);
                            },
                            child: Text("Yes"),
                          ),
                        ],
                      );
                    },
                  );
                },
                visualDensity: VisualDensity.compact,
                leading: const Icon(Icons.password),
                title: const Text("Logout"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle style = TextStyle(
    color: Colors.grey.shade700,
    // fontSize: 18,
  );
}
