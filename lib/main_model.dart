import 'dart:async';

import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  Timer? timer = null;
  DateTime timerTime = DateTime(0);
  bool isStartEnabled = true;
  bool isStopEnabled = false;
  bool isResetEnabled = true;
  bool isEditTimeEnabled = true;


  void changeTimerTime(DateTime time) {
    timerTime = time;
    notifyListeners();
  }

  void resetTimerTime() {
    timerTime = new DateTime(0);
    notifyListeners();
  }

  void startTimer() {
    if (timer == null) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        countUpTime();
      });
    }

    isStartEnabled = false;
    isStopEnabled = true;
    isResetEnabled = false;
    isEditTimeEnabled = false;
    notifyListeners();
  }

  void stopTimer() {
    timer!.cancel();
    timer = null;
    notifyListeners();

    isStartEnabled = true;
    isStopEnabled = false;
    isResetEnabled = true;
    isEditTimeEnabled = true;
    notifyListeners();
  }

  void countUpTime() {
    timerTime = timerTime.add(Duration(seconds: 1));
    notifyListeners();
  }
}
