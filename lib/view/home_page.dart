import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/controller/homepagecontroller.dart';
import 'package:period_tracker/controller/logincontroller.dart';
import 'package:period_tracker/view/side_drawer.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:timeago/timeago.dart' as timeago;

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('bell');

  showNotification() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (value) {},
    );
    flutterLocalNotificationsPlugin.show(
      1,
      'Hii',
      'Your period may starts from today',
      NotificationDetails(
        android:
            AndroidNotificationDetails("123", "Period Reminder Notification"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Period Tracker"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: showNotification,
            icon: Icon(
              Icons.notifications,
            ),
          ),
        ],
      ),
      drawer: SideDrawer(),
      body: GetBuilder<HomepageController>(
        init: HomepageController(),
        builder: (controller) {
          return controller.loading || controller.model == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: ListView(
                    children: [
                      calendarWidget(controller),
                      ledger(),
                      nextPeriodTile(controller),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Card calendarWidget(HomepageController controller) {
    return Card(
      child: TableCalendar(
        sixWeekMonthsEnforced: false,
        focusedDay: controller.activeDate,
        firstDay: DateTime(2020, 01, 01),
        lastDay: DateTime(2100),
        calendarFormat: CalendarFormat.month,
        currentDay: DateTime.now(),
        onPageChanged: (val) {
          controller.changeActiveDate(val);
        },
        startingDayOfWeek: StartingDayOfWeek.sunday,
        weekendDays: const [
          6,
        ],
        rangeStartDay: controller.getStartDate(),
        rangeEndDay: controller.getEndDate(),
        calendarStyle: const CalendarStyle(
          markerDecoration: BoxDecoration(
            color: Color.fromARGB(45, 77, 77, 143),
            shape: BoxShape.circle,
          ),
          isTodayHighlighted: true,
          outsideDaysVisible: false,
          holidayDecoration: BoxDecoration(
            color: Color.fromARGB(74, 8, 27, 31),
            shape: BoxShape.circle,
          ),
          holidayTextStyle: TextStyle(
            color: Colors.white,
          ),
          todayDecoration: BoxDecoration(
            color: Color.fromARGB(255, 109, 103, 105),
            shape: BoxShape.circle,
          ),
        ),
        eventLoader: (day) {
          if (controller.fertileDates.any((element) => element == day.day)) {
            return [""];
          }
          return [];
        },
        holidayPredicate: (val) {
          return val.day == controller.getOvulationDate().day;
        },
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            if (day.weekday == DateTime.saturday) {
              final text = DateFormat.E().format(day);
              return Center(
                child: Text(
                  text,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 126, 86, 53)),
                ),
              );
            }
            return Center(
              child: Text(
                DateFormat.E().format(day),
              ),
            );
          },
        ),
      ),
    );
  }

  Card nextPeriodTile(HomepageController controller) {
    return Card(
      child: SizedBox(
        height: 120,
        width: Get.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Next Period",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black54,
                ),
              ),
              const Spacer(),
              Center(
                child: Column(
                  children: [
                    Text(
                      DateFormat('yyyy MMMM dd').format(
                        controller.model!.lastperioddate.add(
                          const Duration(days: 28),
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.black38,
                      ),
                    ),
                    controller.model!.lastperioddate.add(
                              const Duration(days: 28),
                            ) ==
                            DateTime.now()
                        ? const Text("Today")
                        : Text(
                            "After ${controller.model!.lastperioddate.add(
                                  const Duration(days: 28),
                                ).difference(DateTime.now()).inDays} days",
                          ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Card ledger() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 49, 150, 233),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                const Text("Period dates")
              ],
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(134, 76, 155, 175),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                const Text("Fertile Window")
              ],
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(134, 76, 155, 175),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                const Text("Today")
              ],
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(74, 8, 27, 31),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                const Text("Possible ovulation date")
              ],
            )
          ],
        ),
      ),
    );
  }
}
