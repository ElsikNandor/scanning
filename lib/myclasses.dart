import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scanning/main.dart';
import 'screenargument.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:intl/intl.dart';

String _data = "";
DateTime today = DateTime.now();



class winNumPad extends StatefulWidget {
  const winNumPad({
    super.key,
    required this.constNumText,
    required this.controller,
  });

  final String constNumText;
  final TextEditingController controller;

  @override
  State<winNumPad> createState() => _winNumPad(constNumText: constNumText, controller: controller,);
}

class _winNumPad extends State<winNumPad>{
   _winNumPad({
    required this.constNumText,
    required this.controller,
  });

  String constNumText;
  final TextEditingController controller;

   onKeyboardTap(String value) {
     setState(() {
       constNumText = controller.text + value;
       controller.text = constNumText;
     });
   }

  @override
  Widget build(BuildContext context){
    return
      NumericKeyboard(
          onKeyboardTap: onKeyboardTap,
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 28,
            //backgroundColor: Colors.blueAccent,
          ),
          rightButtonFn: () {
            if (constNumText.isEmpty) return;
            setState(() {
              constNumText = constNumText.substring(0, constNumText.length - 1);
              controller.text = constNumText;
            });
          },
          rightButtonLongPressFn: () {
            if (constNumText.isEmpty) return;
            setState(() {
              constNumText = '';
              controller.text = constNumText;
            });
          },
          rightIcon: const Icon(
            Icons.backspace_outlined,
            color: Colors.blueGrey,
          ),
          mainAxisAlignment: MainAxisAlignment.spaceBetween);
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.text,
    required this.path,
    required this.data,
    required this.user,
    required this.lastSavedNum
  });

  final String text;
  final String path;
  final String data;
  final String user;
  final String lastSavedNum;
  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return
      ElevatedButton(
        style: ElevatedButton.styleFrom(

          //minimumSize: Size(20, 20),
          //maximumSize: Size(100, 100),
        ),
        onPressed: () {
          //myReset();
          Navigator.pushReplacementNamed(context, path,
              arguments: ScreenArguments(user, data, lastSavedNum));
        },
        child: Text(text),
      );
  }
}

class ItemWidgetNotGoodMeter extends StatelessWidget {
  const ItemWidgetNotGoodMeter({
    super.key,
    required this.text,
    required this.path,
    required this.data,
    required this.user,
    required this.lastSavedNum
  });

  final String text;
  final String path;
  final String data;
  final String user;
  final String lastSavedNum;
  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return
      ElevatedButton(
        style: ElevatedButton.styleFrom(

          //minimumSize: Size(20, 20),
          //maximumSize: Size(100, 100),
        ),
        onPressed: () {
          //myReset();
          Navigator.pushReplacementNamed(context, path,
              arguments: ScreenArguments(user, data, lastSavedNum));
        },
        child: Text(text),
      );
  }
}

class Logout
{
  Logout()
  {
    readMeterData = ["-"];
  }
}

class myMenu extends StatelessWidget {
   myMenu({
    super.key,
    required this.username,
     required this.message,
    required this.mlogin,
  });
  var username = '';
  var message = '';
  var mlogin = 0;


  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return PopupMenuButton(
        onSelected: (value) {
        if( value == "/")
          {
            Logout();
            Navigator.pushReplacementNamed(context, "/");
          }
        else if( value == "/back")
          {
            if( this.mlogin == 1 ) {
              Navigator.pushReplacementNamed(context, "/");
            }
            else {
              Navigator.pushReplacementNamed(context, "/constnum",
                  arguments: ScreenArguments(username, message, "-;-")
              );
            }
          }
/*        else if( value == "/dataexport")
        {
              Navigator.pushReplacementNamed(context, "/dataexport",
                arguments: ScreenArguments(username, message, "-;-") );
        }
        else if( value == "/network")
        {
          Navigator.pushReplacementNamed(context, "/network",
              arguments: ScreenArguments(username, message, "-;-") );
        }
        else if( value == "/barcode")
        {
          Navigator.pushReplacementNamed(context, "/barcode",
              arguments: ScreenArguments(username, message, "-;-") );
        }
        else if( value == "/meterstoragetest")
        {
          Navigator.pushReplacementNamed(context, "/meterstoragetest",
              arguments: ScreenArguments(username, message, "-;-") );
        }
        else if( value == "/Dataread")
        {
          Navigator.pushReplacementNamed(context, "/dataReadTest",
              arguments: ScreenArguments(username, message, "-;-") );
        }*/
        else if( value == "quit")
        {
          exit(0);

        }
       },
        itemBuilder: (BuildContext bc) {
          return const [
            PopupMenuItem(
              child: Text("Újrakezdés"),
              value: '/back',
            ),
            PopupMenuItem(
                child: Text("Kijelentkezés"),
                value: '/',
            ),
/*            PopupMenuItem(
              child: Text("Network check"),
              value: '/network',
            ),
            PopupMenuItem(
              child: Text("BarCode"),
              value: '/barcode',
            ),
            PopupMenuItem(
              child: Text("Meter Storage"),
              value: '/meterstoragetest',
            ),
            PopupMenuItem(
              child: Text("DataRead"),
              value: '/Dataread',
            ),*/
           /* PopupMenuItem(
                child: Text("Adat export"),
                value: "/dataexport",
            ),*/
            PopupMenuItem(
              child: Text("Bezár"),
              value: 'quit',
            )
          ];
        }
      );
  }
}

class CounterStorage  {


  String filename = "";
  String adroidDir = "/storage/emulated/0/Documents";
  String winDir = "C:/";//"X:/Elokeszito";//"c:/src";
  String safetyfilename = "safetySave";
  String safetydir = "";
  Future<void> setSaveDirectory(String dirname) async{

    this.winDir = dirname;
    print("Windir: " + dirname);

  }

  Future<String> getFileName() async {
    return await this.filename;
  }

  Future<void> setFName(String fn) async
  {
    this.filename = fn;
  }

  Future<String> getSafetyDir() async {

      final dir = await Directory.current;
        return dir.path;
  }

  Future<String> get _localPath async {


    if( Platform.isAndroid == true){
      final directory = await Directory(this.adroidDir);
         // await Directory("/stdorage/emulated/0/Documents/").exists();
        if( !directory.existsSync() ){
          final directory = await getApplicationDocumentsDirectory();
          return directory.path;
        }
        return directory.path;

     }
    else
      {
        //final directory = await Directory("./build/windows/runner/Release/datas/");
          final directory = await Directory(this.winDir); // c:/src
          if ( !directory.existsSync() )
            {
              final directory = await Directory.current;
              //print(directory.path as String);
              return directory.path;
            }
          return directory.path;
      }

  }


  Future<File> get _localFile async {
    DateTime today = DateTime.now();
    String dateStr = "_";//"${today.year}_${today.month}_${today.day}";
     final path = await _localPath;
      final fn = this.filename;
      String allpath = "$path/"+"$fn"+"_"+"$dateStr"+".csv";
      print(allpath);
      return File(allpath);
    }

  Future<File> get _safetyFile async {
    //DateTime today = DateTime.now();
    //String dateStr = "_";//"${today.year}_${today.month}_${today.day}";
    final path = await getSafetyDir();
    final fn = this.safetyfilename;
    String allpath = "$path/"+"$fn"+".csv";
    print("safety: " + allpath);
    return File(allpath);
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);

    } catch (e) {
      print("nincs!");
      return 0;
    }
  }

  Future<String> readSavedFile() async {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return "content" + contents;


  }

  Future<int> writeMeterData(String meterdata) async {
    final file = await _localFile;
    final safetyS = await _safetyFile;
    try{

      if ( safetyS.existsSync() == true ){
        safetyS.writeAsString('$meterdata\n', mode: FileMode.append, encoding: utf8);
        //print("van");
      }
      else
      {
        safetyS.writeAsString('$meterdata\n', encoding: utf8);
        //print("nincs");
      }
       if ( file.existsSync() == true ){
        file.writeAsString('$meterdata\n', mode: FileMode.append, encoding: utf8);
       //print("van");
      }
        else
          {
            file.writeAsString('$meterdata\n', encoding: utf8);
            //print("nincs");
          }




      return 1;
    }
    catch(e){
      return 0;
    }
    // Write the file

  }

  Future<void> copyToAssets() async {
    final File file = await _localFile;
    file.copy("${_localPath}/counter2.txt");
    //print("write");
  }

  Future<String> getPath() async {
    final f = await _localPath;

    return f;
  }

}

class DateToSave
{

  String formatDT()
  {
    return DateFormat('MM/dd/yyyy hh:mm:ss').format(DateTime.now());
  }


  String get()
  {
    if( today.minute < 10) {
      return "${today.year}-${today.month}-${today.day}_${today.hour}:0${today
          .minute}:${today.second}";
    }
    else
      {
        return "${today.year}-${today.month}-${today.day}_${today.hour}:${today
            .minute}:${today.second}";
      }
  }
}