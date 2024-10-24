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
   //print("ISORDER: " + result.toString());
    //print("ISORDERBEN:" + actualOwner);

    //if(actualOwner == "MG") {
    //print("Ell: " + dataStore[1].split(";")[1]);
    //if(dataStore[1].split(";")[1] == "Magáz") {
      //isorder.value = true;
      //return true;
    //}
    /*if (result > 10) {
      orderCheck = true;
      isorder.value = true;
      return true;
    } else {
      orderCheck = false;
    }*/
      isorder.value = true;
    return false;

    return false;
  }

}