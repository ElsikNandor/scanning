import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChannels, rootBundle;
import 'package:scanning/main.dart';
import 'dart:async';
import 'screenargument.dart';
import 'myclasses.dart';
import 'package:intl/intl.dart';

final _formKey = GlobalKey<FormState>();
String argString = "Username";
String meterType = "";
class NotGoodMeter extends StatefulWidget {
  const NotGoodMeter({super.key});

  @override
  State<NotGoodMeter> createState() => _NotGoodMeterState();
}

class _NotGoodMeterState extends State<NotGoodMeter> {
String _data = "";
String saveDirName = "";
String savedate = "";
  Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/notgood_meter.txt');
    setState(() {
      _data = loadedData;
    });
  }

  Future<void> _loadData_dn() async {
    final loadedData = await rootBundle.loadString('assets/savedirname.txt');
    setState(() {
      saveDirName = "${loadedData.split(";")[0]}:\\${loadedData.split(";")[1]}";
    });
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    _loadData();
    _loadData_dn();
    setState(() {
      savedate = DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now());
    });
  }


  @override
  Widget build(BuildContext context) {

    int metersCount = _data.split(";").length.toInt();
print(_data);
    final CounterStorage storage = CounterStorage();
    storage.setSaveDirectory(saveDirName);
    String saveStatus = "";
    String saveText = "Sikeres mentés: ";
    return Scaffold(
      appBar: AppBar(
          title: Text("Típus kiválasztása | Adatrögzítő: ${readMeterDataMap["user"].toString() } | Megrendelő: ${ readMeterDataMap["owner"] }"),
          actions: <Widget>[
            myMenu( username: readMeterDataMap['user'].toString(), message: readMeterDataMap['user'].toString(), mlogin: 1),
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
          return
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 100), backgroundColor: Colors.red,
                maximumSize: Size(150, 100),

              ),
              onPressed: () {
                storage.filename = "meterdata_notgood_${readMeterDataMap["order_number"]}" ;
                readMeterDataMap.addEntries({"savedate" : savedate}.entries);
                readMeterDataMap.update("lastSaveNum", (value) => readMeterDataMap["constnum"].toString());
                readMeterDataMap.update("lastSaveQuality", (value) => "selejt");
                readMeterDataMap.update("lastSaveQualityText", (value) => _data.split(";")[index]);
                try{
                  //argString += ";" +  savedate;
                  storage.writeMeterData(readMeterDataMap);
                  setState(() {
                    saveStatus ="Sikeres mentés!";
                  });

                }catch (e) {
                  // If encountering an error, return 0
                  setState(() {
                    saveStatus ="Nem sikerült a mentés! Kérj segítséget!";
                  });

                }
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 600, left: 300, right: 300),
                      content: //Container(
                      //child: Text(saveText + "Jó mérők listájába."),
                      //tex
                      //),
                      Text("${saveText}Selejt mérők listájába.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0, // insert your font size here
                        ),
                      ),
                      dismissDirection: DismissDirection.none,
                      backgroundColor: Colors.red,

                    ));

                   // SnackBar(content: Text("Selejt mérő kiválasztva.")));//Text(saveStatus +" " + storage.filename)

                Navigator.pushReplacementNamed(context, "/constnum");
              },
              icon: Icon( Icons.restore_from_trash,
                size: 24,
              ),
              label: Text(_data.split(";")[index]),
            );

          /*ItemWidgetNotGoodMeter(text:  _data.split(",")[index],
              path: '/order_number',
              data: argString+';'+_data.split(",")[index], user: argString.split(";")[0],
              lastSavedNum: argString.split(";")[3]+";"+"selejt",
              //ScreenArguments(argString.split(";")[0], argString.split(";")[0]+";"+argString.split(";")[1]+";"+argString.split(";")[2],
          //  argString.split(";")[3]+";"+"selejt") );
          );*/
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