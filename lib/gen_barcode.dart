import 'package:flutter/material.dart';
import 'myclasses.dart';

import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class Gen_BarCode extends StatefulWidget {
  const Gen_BarCode({super.key});

  @override
  State<Gen_BarCode> createState() => _Gen_BarCodeState();
}

class _Gen_BarCodeState extends State<Gen_BarCode> {

  String barCodeText = "AD12345678";

  @override
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
              child: SizedBox(
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