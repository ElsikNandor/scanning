import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChannels, rootBundle;
import 'dart:async';
import 'screenargument.dart';
import 'myclasses.dart';

String argString = "Username";
String meterType = "";
class yearOfManufacture extends StatefulWidget {
  const yearOfManufacture({Key? key}) : super(key: key);

  @override
  State<yearOfManufacture> createState() => _yearOfManufactureState();
}

class _yearOfManufactureState extends State<yearOfManufacture> {
  String _data = "";
  Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/yofs.txt');
    setState(() {
      _data = loadedData;
    });
  }
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    _loadData();
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    int metersCount = _data.split(",").length.toInt();
    argString = args.message;
    return Scaffold(
      appBar: AppBar(
          title: Text("Gyártási év kiválasztása | "
              + "Adatrögzítő: " + args.message.split(";")[0]
              + " | Megrendelő: " + args.message.split(";")[1]),
          actions: <Widget>[
            myMenu(username: argString.split(";")[0], message: argString, mlogin : 0)
          ]
      ),
      body: Scrollbar( child:
      GridView.count(
        primary: false,
        padding: const EdgeInsets.all(50),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: 7,
        children:
        List.generate(metersCount, (index) {
          return ItemWidget(text:  _data.split(",")[index],
              path: '/countpos',
              data: argString+';'+_data.split(",")[index], user: argString.split(";")[0],
            lastSavedNum: "-;-",
          );
        }),
      ),
      ),
    );
  }
}
