import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'screenargument.dart';
import 'myclasses.dart';

String argString = "Username";
String meterType = "";
class saveData extends StatefulWidget {
  const saveData({Key? key}) : super(key: key);

  @override
  State<saveData> createState() => _saveDataState();
}

class _saveDataState extends State<saveData> {
  String _data = "";

  Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/metertype.txt');
    setState(() {
      _data = loadedData;
    });
  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  void initState() {
    super.initState();
    _loadData();
    setState(() {

    });
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
    //final ButtonStyle style = TextButton.styleFrom(textStyle:  Theme.of(context).colorScheme.onPrimary,);
    return Scaffold(
        appBar: AppBar(
            title: Text(argString.split(";")[0] + " - Összegzés: "),
            actions: <Widget>[
              myMenu(username: argString.split(";")[0], message: argString, mlogin: 0)
            ]
        ),
        body: Center(child: Text("ws")
        )
    );
  }
}