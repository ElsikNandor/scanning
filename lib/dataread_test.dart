import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChannels, rootBundle;
import 'dart:async';
import 'screenargument.dart';
import 'myclasses.dart';
import "data_stores.dart";

String argString = "Username";
String meterType = "";
String ordernumber = "12345";
String gysz = "76543210";
String dataPath = "C:/orders/";
int rCount = 0;
dataRead orderDataRead = dataRead();
convertData converter = convertData();
orderDirRead orderDir = orderDirRead();
ownersDataConverter ownConv = ownersDataConverter();
class dataReadTest extends StatefulWidget {
  const dataReadTest({Key? key}) : super(key: key);

  @override
  State<dataReadTest> createState() => _dataReadTestState();
}

class _dataReadTestState extends State<dataReadTest> {
  List<String> _data = [];

  /*Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('C:/src/'+ordernumber);
    setState(() {
      _data = loadedData;
    });
  }*/
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    //ordernumber = ordernumber + ".csv";
    //_loadData();
    orderDataRead.addDataFile("C:/orders", ordernumber, "fogaz"); // class, amiből kiindul az egész betöltés, itt lesz magadva a szolgáltató, az alapján kell kiolvasni az adatállományt
    //orderDataRead.readFile() ;
    orderDir.setDir(dataPath);
    orderDir.getDir();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    //int metersCount = _data.split(",").length.toInt();
    argString = args.message;
    print("data: " + orderDataRead.ordernumber);
    Map<int, String> conv = {0:"-"};
    Map<String, String> rowsData = {"-" : "-"};
    Future<void> _loadData() async {
      final loadedData = await orderDataRead.readFile() ; //Kell a beolvasáshoz
      if( rCount < 3 ) { // hogy ne pörögjön a state a beolvasás után, de 2-3 legalább kell, hogy betöltse
        setState(() {
          _data = loadedData; //_data-ába kerül a fájl tartalma
        });
        rCount++;
      }
    }

    if( rCount == 3 )
      {
        //converter.addDataStore(_data);
        //conv = converter.convert();
      }
    void findPersonUsingWhere(List<String> dataList,
        String gysz) {
      // Return list of people matching the condition
      final found = dataList.where((element) =>
      element.split(";")[0] == gysz);

      if (found.isNotEmpty) {
        print('Using where: ${found.first}');
        ownConv.setDatas(found.first, "Főgáz");
        rowsData = ownConv.convertData();
      }
    }

    //setState(() {
      _loadData();

    findPersonUsingWhere(_data, gysz);

    orderDir.orderDirExists(ordernumber, "FG");
    //});
    return Scaffold(
      appBar: AppBar(
          title: Text("Megrendelő kiválasztása | "
              + "Adatrögzítő: " + args.message.split(";")[0]),
          actions: <Widget>[
            myMenu(username: argString.split(";")[0], message: argString, mlogin: 1)
          ]
      ),
      body:
          ListView(
            children: [
                Text(orderDataRead.owner.toString()),
                Text(conv[5].toString()),
            //SingleChildScrollView( child:
                Text(_data[1]),
                Text(_data[25]),
            Text(rowsData["sort_prod_num"].toString()),

            //),
            ],
          ),

    );
  }
}
