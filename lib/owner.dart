import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChannels, rootBundle;
import 'package:scanning/constnum.dart';
import 'package:scanning/main.dart';
import 'dart:async';
import 'screenargument.dart';
import 'myclasses.dart';

final _formKey = GlobalKey<FormState>();
String argString = "Username";
String meterType = "";
class mOwner extends StatefulWidget {
  const mOwner({super.key});

  @override
  State<mOwner> createState() => _mOwnerState();
}

class _mOwnerState extends State<mOwner> {
  String _data = "";
/*  Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/owners.txt');
    setState(() {
      _data = loadedData;
    });
  }*/
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    //_loadData();
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    //int metersCount = _data.split(",").length.toInt();
    int metersCount = ownersList.length;
    //argString = args.message;
    print("reading: " + readMeterDataMap.toString());
    return Scaffold(
      appBar: AppBar(
          title: Text("Megrendelő kiválasztása | Adatrögzítő: ${readMeterDataMap['user'].toString()}"),
          actions: <Widget>[
            myMenu(username: readMeterDataMap['user'].toString(), message: argString, mlogin: 1)
          ]
      ),
      body: Scrollbar( child:
      GridView.count(
        primary: false,
        padding: const EdgeInsets.all(50),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: 5,
        children:
        List.generate(metersCount, (index) {
          return ItemWidget(text: ownersList[index].toString(),
          //_data.split(",")[index],
              path: '/order_number',
              data: '${ownersList[index].toString()}',
              user: readMeterDataMap['user'].toString(),
              //data: '$argString;${ownersList[index].toString()}', user: argString.split(";")[0],
            page : "owner",
              lastSavedNum: "-",
          );
        }),
      ),
      ),
    );
  }
}


class constInputForm extends StatefulWidget {
  const constInputForm({super.key});
  @override
  constInputFormState createState() {
    return constInputFormState();
  }
}

class constInputFormState extends State<constInputForm> {
  @override
  Widget build(BuildContext context) {
    double itmp = 0;
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Gázmérő típusa',
              border: OutlineInputBorder(),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                //myReset();
                return 'A mező nem lehet üres!';
              }

              meterType = value;
              return null;
            },
          ),

        ],
      ),
    );
  }
}