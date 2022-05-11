import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:period_tracker/const.dart';
import 'package:period_tracker/controller/datasavingcontroller.dart';
import 'package:period_tracker/model/profilemodel.dart';
import 'package:period_tracker/utils/remoteservices.dart';
import 'package:period_tracker/view/blog_page.dart';
import 'package:period_tracker/view/bmicalculator.dart';
import 'package:period_tracker/view/breathe.dart';
import 'package:period_tracker/view/home_page.dart';
import 'package:period_tracker/view/newbmicalculator.dart';
import 'package:period_tracker/view/side_drawer.dart';

import '../controller/logincontroller.dart';
import 'symptoms.dart';

class MainPanel extends StatefulWidget {
  const MainPanel({Key? key}) : super(key: key);

  @override
  State<MainPanel> createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel> {
  int selectedPage = 1;
  PageController pageController = PageController(initialPage: 1);
  DatasavingController dsc = DatasavingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPage,
        onTap: (val) {
          selectedPage = val;
          pageController.jumpToPage(val);
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.health_and_safety_rounded,
            ),
            label: "Health Tips",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_rounded),
            label: "Symptoms",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            label: "BMI",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mood),
            label: "Breathe",
          ),
        ],
      ),
      body: FutureBuilder<ProfileModel?>(
        future: dsc.readProfile(),
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  decoration: const BoxDecoration(
                    gradient: linearGradient,
                  ),
                  child: PageView(
                    onPageChanged: (val) {
                      selectedPage = val;
                      setState(() {});
                    },
                    controller: pageController,
                    children: [
                      NewsPage(),
                      Homepage(),
                      SymptomsTracker(),
                      // BMICalculator(),
                      BMICalculator2(),
                      snapshot.data!.premium == 1
                          ? BreathingPage()
                          : Container(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Pay To Unlock"),
                                    ElevatedButton(
                                      onPressed: () {
                                        final config = PaymentConfig(
                                          amount:
                                              10000, // Amount should be in paisa
                                          productIdentity: 'dell-g5-g5510-2021',
                                          productName: 'Dell G5 G5510 2021',
                                          productUrl:
                                              'https://www.khalti.com/#/bazaar',
                                        );
                                        KhaltiScope.of(context).pay(
                                          config: config,
                                          preferences: [
                                            PaymentPreference.khalti,
                                            PaymentPreference.connectIPS,
                                            PaymentPreference.eBanking,
                                            PaymentPreference.sct,
                                          ],
                                          onSuccess: (onSuccess) async {
                                            await RemoteServices.savePayment(
                                              DateTime.now(),
                                              500.0,
                                              "Premium Subscription",
                                              snapshot.data!.id,
                                              onSuccess.mobile,
                                            );
                                            Fluttertoast.showToast(
                                                msg: "Payment Success");
                                            RemoteServices.unlockPremium(
                                              snapshot.data!.id,
                                            );
                                            ProfileModel profile =
                                                snapshot.data!;
                                            profile.premium = 1;
                                            dsc.saveProfile(profile);
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/splash',
                                                (route) => false);
                                          },
                                          onFailure: (onFailure) {
                                            Fluttertoast.showToast(
                                                msg: onFailure.message);
                                          },
                                          onCancel: () {
                                            Fluttertoast.showToast(
                                                msg: "Payment Canelled");
                                          },
                                        );
                                      },
                                      child: Text("Pay now"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
