import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class BreathingPage extends StatefulWidget {
  BreathingPage({Key? key}) : super(key: key);

  @override
  State<BreathingPage> createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
    );
    _controller.stop();

    stopWatchTimer.rawTime.listen((event) {
      if (event == 0) {
        handleEnd();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    stopWatchTimer.dispose();
    super.dispose();
  }

  final stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromMinute(1),
    onChangeRawSecond: (val) {},
  );

  handleEnd() {
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    breathing = false;
    setState(() {});
    _controller.stop();
  }

  bool breathing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Lottie.asset(
            'assets/breathe.json',
            animate: breathing,
            controller: _controller,
            onLoaded: (value) {
              _controller.duration = value.duration;
            },
          ),
          StreamBuilder<int>(
            stream: stopWatchTimer.rawTime,
            initialData: 0,
            builder: (context, snap) {
              final value = snap.data;
              final displayTime = StopWatchTimer.getDisplayTime(
                value!,
                hours: false,
              );
              return Column(
                children: <Widget>[
                  Text(
                    getText(
                      double.parse(
                        (snap.data! / 1000).toString(),
                      ).round(),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.brown,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      displayTime.split('.').first,
                      style: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          stopWatchTimer.isRunning
              ? TextButton(
                  onPressed: () {
                    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                    breathing = false;
                    setState(() {});
                    _controller.stop();
                  },
                  child: Text("Stop"),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        stopWatchTimer.onExecute.add(StopWatchExecute.start);
                        // stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                        breathing = true;
                        setState(() {});
                        _controller.repeat();
                      },
                      child: Text("Start"),
                    ),
                    TextButton(
                      onPressed: () {
                        stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                        _controller.reset();
                      },
                      child: Text("Reset"),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  String getText(int val) {
    int data = int.parse(val.toString());
    if (data == 60) {
      return "Press start to start exercise";
    } else if (data < 60 && data > 50) {
      return "Prepare";
    } else if (inhale.any((element) => element == data)) {
      return "Inhale";
    } else if (exhale.any((element) => element == data)) {
      return "Exhale";
    } else {
      return "";
    }
  }

  List<int> inhale = <int>[
    50,
    49,
    48,
    44,
    43,
    42,
    38,
    37,
    36,
    32,
    31,
    30,
    26,
    25,
    24,
    20,
    19,
    18,
    14,
    13,
    12,
    8,
    7,
    6,
    2,
    1,
    0
  ];
  List<int> exhale = <int>[
    47,
    46,
    45,
    41,
    40,
    39,
    35,
    34,
    33,
    29,
    28,
    27,
    23,
    22,
    21,
    17,
    16,
    15,
    11,
    10,
    9,
    5,
    4,
    3
  ];
}
