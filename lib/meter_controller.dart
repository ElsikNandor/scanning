import 'package:flutter/material.dart';
import 'package:scanning/constnum.dart';
import 'package:scanning/main.dart';
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

    //if(actualOwner == "OT")
    if(ownerMap[mDataClass.getOwner()] == "OT")
      {
        print("metercontroller OT");
        ismeter.value = false;
        checkmeter.value = false;
        result = 2;
        return false;
      }

    if (result < 1) {
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