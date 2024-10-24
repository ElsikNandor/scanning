import 'package:flutter/material.dart';
import 'package:scanning/constnum.dart';
import 'package:scanning/order_number.dart';


class MeterController {
  ValueNotifier<bool> ismeter = ValueNotifier(false);
  ValueNotifier<bool> checkmeter = ValueNotifier(true);

  Future<void> init() async {
    int result = orderNumberAttempt;
    isMeter(result);
  }

  bool isMeter(int result) {
    print("metercontroller");

    if(actualOwner == "MG")
      {
        print("metercontroller MG");
        ismeter.value = false;
        checkmeter.value = false;
        return false;
      }

    if (result < 2) {
      ismeter.value = true;
      checkmeter.value = true;
      return true;
    } else {
      ismeter.value = false;
      checkmeter.value = true;
      return false;
    }
    return false;

    return false;
  }

}