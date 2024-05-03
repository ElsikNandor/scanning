import 'package:flutter/material.dart';
import 'package:scanning/dataread_test.dart';
import 'package:scanning/main.dart';


class OrderController {
  ValueNotifier<bool> isorder = ValueNotifier(false);

  Future<void> init() async {
    int result = await readMeterData.length;
    isOrder(result);
  }

  bool isOrder(int result) {
    print("ISORDER");
    if (result > 10) {
      orderCheck = true;
      isorder.value = true;
      return true;
    } else
      orderCheck = false;
      isorder.value = false;
    return false;

    return false;
  }

}