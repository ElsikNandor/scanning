import 'package:flutter/material.dart';
import 'package:scanning/main.dart';
import 'package:scanning/order_number.dart';


class OrderController {
  ValueNotifier<bool> isorder = ValueNotifier(false);

  Future<void> init() async {
    int result = readMeterData.length;
    isOrder(result);
  }

  bool isOrder(int result) {
    print("ISORDER");
    print(actualOwner);

    if(actualOwner == "MG") {
      isorder.value = true;
      return true;
    }
    if (result > 10) {
      orderCheck = true;
      isorder.value = true;
      return true;
    } else {
      orderCheck = false;
    }
      isorder.value = false;
    return false;

    return false;
  }

}