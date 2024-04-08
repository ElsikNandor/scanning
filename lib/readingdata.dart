import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scanning/dataread_test.dart';
import 'package:scanning/fileFlutter.dart';
import 'dart:async';
import 'screenargument.dart';
import 'myclasses.dart';
import 'dart:io';
import 'connection_alert_widget.dart';
import 'connectivity_controller.dart';

String argString = "Username";
String meterType = "";
class readingData extends StatefulWidget {
  const readingData({Key? key}) : super(key: key);

  @override
  State<readingData> createState() => _readingDataState();
}

class _readingDataState extends State<readingData> {
  //String _data = "";
  File fname = File("");
  String savedate = "";
  ConnectivityController connectivityController = ConnectivityController();

  ValueNotifier<bool> network_state = ValueNotifier(false);
  String checknetwork = "";
  /*Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/metertype.txt');
    setState(() {
      _data = loadedData;
    });
  }
*/
 String saveDirName = "";
  Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/savedirname.txt');
    setState(() {
      saveDirName = loadedData.split(";")[0]+":\\"+loadedData.split(";")[1];
    });
  }

  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    connectivityController.init();
    super.initState();
    _loadData();
    setState(() {
      savedate = DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now()); // DateToSave().get();

      checknetwork = connectivityController.isConnected.value.toString();
      //Timer.periodic(Duration(seconds: 1), (Timer t) => savedate = DateToSave().get());

      });


      //super.initState();

  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    //int metersCount = _data.split(",").length.toInt();
    argString = args.message;
    final CounterStorage storage = CounterStorage();
    storage.setSaveDirectory(saveDirName);
    String saveStatus = "";
    String saveText = "Sikeres mentés: ";
    ValueNotifier reset = ValueNotifier(false);

    ValueNotifier<String> _mystring = ValueNotifier<String>('');
  setState(() {
      checknetwork = connectivityController.isConnected.value.toString();

      _mystring.addListener(() {
        //_controller.text =  connectivityController.isConnected.value.toString();
      });

      //_mystring.addlistener(() => _controller.text = _mystring.value);

  });

    return Scaffold(
      appBar: AppBar(
        title: Text("Összegzés: " + savedate), //+ " network: " + checknetwork ),
        actions: <Widget>[
          myMenu(username: argString.split(";")[0], message: argString, mlogin: 0,)
        ]
      ),
      body:Center(
        child:
        Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              verticalDirection: VerticalDirection.up,
              children: [

                Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 50,),
          myListElements(title: "Megrendelő:", content: argString.split(";")[1]),
          SizedBox(height: 5,),
          myListElements(title: "Megrendelésszám:", content: argString.split(";")[2]),
          SizedBox(height: 5,),
          myListElements(title: "Gyártási szám:", content: argString.split(";")[3]),
          SizedBox(height: 5,),
          myListElements(title: "Típus:", content: argString.split(";")[4]),
           SizedBox(height: 5,),
          myListElements(title: "Gyártási Év:", content: argString.split(";")[6]),
          SizedBox(height: 5,),
          myListElements(title: "Számlálóállás:", content: argString.split(";")[5]),
          SizedBox(height: 5,),
          myListElements(title: "Cserekerék:", content: argString.split(";")[6] == "Metrix" ? argString.split(";")[7] : argString.split(";")[7]),
          SizedBox(height: 5,),
          myListElements(title: "Rögzítés időpontja:", content: savedate),
        ],//+"_" + argString.split(";")[8]+"_" + argString.split(";")[9]
      ),

          ValueListenableBuilder(
              valueListenable: connectivityController.isConnected,
              builder: (context, value, child) {
                  if (value.toString() == "true"  ) {
                    return Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                        ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 100),
                          maximumSize: Size(150, 100),
                          primary: Colors.green,
                        ),
                              icon: Icon(
                                Icons.done,
                              size: 24,
                            ),
                            onPressed:

                                () {
                                  rCount = 0;
                              //myReset();
                                storage.filename = "meterdata_good_" + argString.split(";")[2];
                              //setState(() {
                                try{
                                  argString += ";" + savedate;
                                      //"${today.year}-${today.month}-${today.day}_${today.hour}:${today.minute}:${today.second}";
                                  storage.writeMeterData(argString);
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
                                    SnackBar(content: Text(saveText + "Jó mérők listájába."))); //Text(saveStatus +" " + storage.filename)
                              //});
                              Navigator.pushReplacementNamed(context, "/constnum",
                                  arguments: ScreenArguments(argString.split(";")[0],
                                      argString.split(";")[0]+";"+argString.split(";")[1]+";"+argString.split(";")[2],
                                      argString.split(";")[3]+";"+"jó"
                                  )
                              );
                            },
                            label: Text("Jó"),
                          ),
                                  SizedBox(
                                    height: 80,
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(150, 100),
                                      maximumSize: Size(150, 100),
                                      primary: Colors.red,

                                    ),
                                    onPressed: () {
                                      //storage.filename = "meterdata_notgood_" ;
                                      argString += ";" + savedate;
                                      try{
                                        //storage.writeMeterData(argString);
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
                                          //SnackBar(content: Text(saveText + "Selejt mérők listájába.")));
                                      SnackBar(content: Text("Selejt mérő kiválasztva.")));//Text(saveStatus +" " + storage.filename)
                                      //Navigator.pushReplacementNamed(context, "/constnum",
                                      Navigator.pushReplacementNamed(context, "/notgood_meter",
                                        //arguments: ScreenArguments(argString.split(";")[0], argString.split(";")[0]+";"+argString.split(";")[1]+";"+argString.split(";")[2],
                                          //  argString.split(";")[3]+";"+"selejt") );
                                          arguments: ScreenArguments(argString.split(";")[0], argString,
                                              argString.split(";")[3]+";"+"selejt") );
                                    },
                                    icon: Icon( Icons.restore_from_trash,
                                      size: 24,
                                    ),
                                    label: Text("Selejt"),
                                  )
                                ]
                                );
                  } else {
                  return const Text("");
                  }
                }
                ),
            ],
          ),
            SizedBox(
              height: 10,
            ),
            const ConnectionAlert(),

              ],

            ),

      ),
    );
  }





}

class myListElements extends StatelessWidget {
  const myListElements({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      alignment: Alignment.centerLeft,
      width: 500,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        border: Border.all(width: 1, color: Colors.black,),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          "$title " + content
      ),
    );
  }

}

