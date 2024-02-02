import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'screenargument.dart';
import 'myclasses.dart';
import 'dart:io';

String argString = "Username";
String meterType = "";
class dataExport extends StatefulWidget {
  const dataExport({Key? key}) : super(key: key);

  @override
  State<dataExport> createState() => _dataExportState();
}

class _dataExportState extends State<dataExport> {
  String _data = "";
  File fname = File("");

  Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/metertype.txt');
    setState(() {
      _data = loadedData;
    });
  }
  bool isChecked = false;
  List<Map<String, dynamic>> dataList = [];
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    _loadData();
    for (int i = 0; i < 20; i++) {
      dataList.add({
        "title": "Item $i",
        "isChecked": false
      });
    }
  }
    @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as ScreenArguments;
    int metersCount = _data
        .split(",")
        .length
        .toInt();
    argString = args.message;
    final CounterStorage storage = CounterStorage();
    String saveStatus = "";
    String saveText = "Sikeres mentés: ";

    return Scaffold(
        appBar: AppBar(
            title: Text("Adatok kimentése"),
            actions: <Widget>[
              myMenu(username: argString.split(";")[0],
                message: argString,
                mlogin: 0,)
            ]
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: dataList.length,
          itemBuilder: (context, index) =>
              CheckboxListTile(
                value: dataList[index]["isChecked"],
                onChanged: (value) {
                  setState(() {
                    dataList[index]["isChecked"] = value!;
                  });
                },
                title: Text( "valami "+
                  dataList[index]["title"],
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
        )
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



