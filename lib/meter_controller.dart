import 'package:flutter/material.dart';
import 'package:scanning/constnum.dart';
import 'package:scanning/dataread_test.dart';
import 'package:scanning/main.dart';
import 'package:scanning/order_number.dart';


class MeterController {
  ValueNotifier<bool> ismeter = ValueNotifier(false);

  Future<void> init() async {
    int result = await orderNumberAttempt;
    isMeter(result);
  }

  bool isMeter(int result) {
    print("ISOLDER");

    if(actualOwner == "MG")
      {
        ismeter.value = false;
        return false;
      }
    if (result < 2) {
      ismeter.value = true;
      return true;
    } else
      ismeter.value = false;
    return false;

    return false;
  }

}