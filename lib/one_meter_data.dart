import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChannels, rootBundle;
import 'package:scanning/main.dart';
import 'screenargument.dart';
import 'myclasses.dart';
import 'dart:async';

import 'data_stores.dart';

String spn = "";
String pn = "";
String on = "";

class One_Meter_Data extends StatefulWidget {
  const One_Meter_Data({super.key});

  @override
  State<One_Meter_Data> createState() => _One_Meter_DataState();
}

class _One_Meter_DataState extends State<One_Meter_Data> {


  meterDatas md = meterDatas();
  dataRead fogaz = dataRead();
  bool loadStorage = false;

/*  String _orderdata = "";
  String orderNumber = "";*/

  Map<int, String> rowData = {0:"-"};
  List<String> datastorage = [];
  Future<void> _loadMeterData() async {
    final loadedData2 = await fogaz.readFile();
     datastorage = loadedData2;
  }
/*  Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/order_tmp.txt');
    final dataStorageLocation = await rootBundle.loadString('assets/savedirname.txt');
    final path = await dataStorageLocation.split(";")[0]+":\\"+dataStorageLocation.split(";")[1];
    final file = await File(path+"\\"+loadedData+".csv");
    final loadedData2 = await file.readAsString();

    setState(() {
      orderNumber = loadedData;
      datastorage = loadedData2;

    });
  }*/
  

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    //_loadData();

    setState(() {
      //fogaz.addDataFile("C:/Storage/Flogi/allomanyok", _orderdata);
      //_loadMeterData();
      spn = "1234";
      pn = "123456";
      on = "10001";
    });
  }



  @override
  Widget build(BuildContext context) {
/*    convertData convert = convertData();
    convert.addDataStore(datastorage);
    convert.convert();*/
    int rowss = convert.getRows();
    //print(datastorage);
    print("rows-: $rowss");
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    md.add_MeterDatas(spn, pn, on);
    //print("data: "+ fogaz.readSavedFile());
    //print("order: " + orderNumber);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Meter Storage Test "),
            actions: [myMenu(username : "", message: "", mlogin: 1,)],
          ),
          body: Center(
              child: SizedBox(
                height: 200,
                width: 300,
                child: 
                  Column(
                    children: [
                      Text("Rövid gyáriszám: ${md.getSortProductNumber()}"),
                      Text("Gyáriszám: ${md.getProductNumber()}"),
                      Text("Megrendelésszám: ${md.getOrderNumber()}"),
                      //Text("infó: " + _orderdata.split(";")[0]),
                      Text("storage: ${datastorage[0]}"),
                      Text("sorok: ${convert.getRows()}"),
                      Text("data: ${convert.dataStore}"),
                      Text(mainakarmi),
                      SizedBox(
                        width: 100,
                        height: 20,
                        child:

                      ElevatedButton(
                        onPressed: () async {
                         // await _loadData();
                      setState(() {
                        //print(orderNumber);
                      });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,),
                        child: const Text(
                          "Click",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      )
                      ),
    ],
                ),
              )

          )),
    );
  }

}