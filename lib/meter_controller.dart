import 'package:flutter/material.dart';
import 'package:scanning/constnum.dart';
import 'package:scanning/dataread_test.dart';
import 'package:scanning/main.dart';


class MeterController {
  ValueNotifier<bool> ismeter = ValueNotifier(false);

  Future<void> init() async {
    int result = await orderNumberAttempt;
    isMeter(result);
  }

  bool isMeter(int result) {
    print("ISOLDER");
    if (result < 2) {
      ismeter.value = true;
      return true;
    } else
      ismeter.value = false;
    return false;

    return false;
  }

}