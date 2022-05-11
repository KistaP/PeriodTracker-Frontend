import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:period_tracker/view/admin/viewallpayments.dart';
import 'package:period_tracker/view/admin/viewallprofiles.dart';
import 'package:period_tracker/view/generatereport.dart';
import 'package:period_tracker/view/admin/admin_panel.dart';
import 'package:period_tracker/view/admin/upload_health_tips.dart';
import 'package:period_tracker/view/admin/upload_hospital_data.dart';
import 'package:period_tracker/view/admin/uploadhealthtipslinks.dart';
import 'package:period_tracker/view/changepasswordpage.dart';
import 'package:period_tracker/view/home_page.dart';
import 'package:period_tracker/view/login.dart';
import 'package:period_tracker/view/main_panel.dart';
import 'package:period_tracker/view/resetpasswordpage.dart';
import 'package:period_tracker/view/setup/setup_tour.dart';
import 'package:period_tracker/view/signup.dart';
import 'package:period_tracker/view/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_56c506ad1e594af582bcc9a62fc6e1fb",
        builder: (context, navigatorKey) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.brown,
              appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(179, 163, 105, 95),
                elevation: 0,
                centerTitle: true,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Color.fromARGB(255, 187, 111, 91),
                elevation: 0,
                selectedItemColor: Color.fromARGB(255, 143, 98, 83),
                unselectedItemColor: Colors.black.withOpacity(0.5),
                showSelectedLabels: true,
                showUnselectedLabels: false,
              ),
            ),
            home: SplashPage(),
            routes: {
              '/admin': (_) => const AdminPanel(),
              '/splash': (_) => const SplashPage(),
              '/uploadHealthTips': (_) => UploadHealthTips(),
              '/uploadHealthTips': (_) => UploadHealthTips(),
              '/uploadHealthTipsLinks': (_) => UploadHealthTipsLinks(),
              '/uploadHospitalData': (_) => UploadHospitalData(),
              '/login': (_) => LoginPage(),
              '/signup': (_) => SignupPage(),
              '/homepage': (_) => Homepage(),
              '/setuptour': (_) => SetupTour(),
              '/forgotpassword': (_) => ForgotPassword(),
              '/changepassword': (_) => ChangePassword(),
              '/myreport': (_) => GenerateReportPage(),
              '/allusers': (_) => ViewAllProfiles(),
              '/allpayments': (_) => ViewAllPayments(),
            },
          );
        });
  }
}
