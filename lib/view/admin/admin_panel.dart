import 'package:flutter/material.dart';
import 'package:period_tracker/const.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Attention"),
                    content: const Text("Are you sure you want to logout ?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No"),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("Yes"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          children: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pushNamed(context, '/uploadHealthTips');
            //   },
            //   child: adminCard(context, "Upload Health Tips"),
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pushNamed(context, '/uploadHospitalData');
            //   },
            //   child: adminCard(context, "Upload Hospital"),
            // ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/uploadHealthTipsLinks');
              },
              child: adminCard(context, "Upload Links"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/allpayments');
              },
              child: adminCard(context, "View Purchase"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/allusers');
              },
              child: adminCard(context, "View Users"),
            ),
          ],
        ),
      ),
    );
  }

  Container adminCard(BuildContext context, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
