import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanning/readingdata.dart';
import 'screenargument.dart';
import 'myclasses.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class Gen_BarCode extends StatefulWidget {
  const Gen_BarCode({Key? key}) : super(key: key);

  @override
  State<Gen_BarCode> createState() => _Gen_BarCodeState();
}

class _Gen_BarCodeState extends State<Gen_BarCode> {

  String barCodeText = "AD12345678";

  void initState() {
    super.initState();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Vónalkód generátor"),
            actions: [myMenu(username : "", message: "", mlogin: 1,)],
          ),
          body: Center(
              child: Container(
                height: 150,
                width: 300,
                child: SfBarcodeGenerator(
                  value: barCodeText,
                  symbology: Code128A(),
                  showValue: true,
                ),
              )

          )),
    );
  }

}