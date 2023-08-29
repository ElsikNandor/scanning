//import 'dart:html';
import 'package:flutter/material.dart';
import 'screenargument.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
//import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';
String _data = "";
class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.text,
    required this.path,
    required this.data,
    required this.user,
  });

  final String text;
  final String path;
  final String data;
  final String user;
  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(50, 50),
          maximumSize: Size(50, 50),
        ),
        onPressed: () {
          //myReset();
          Navigator.pushReplacementNamed(context, path,
              arguments: ScreenArguments(user, data));
        },
        child: Text(text),
      );
  }
}

class myMenu extends StatelessWidget {
   myMenu({
    super.key,
    required this.username
  });
  var username = '';

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return PopupMenuButton(
        onSelected: (value) {
        if( value == "/")
          {
            Navigator.pushReplacementNamed(context, "/");
          }
        else if( value == "/back")
          {
            Navigator.pushReplacementNamed(context, "/constnum",
              arguments: ScreenArguments(username, username)
            );
          }
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
            PopupMenuItem(
              child: Text("Bezár"),
              value: 'quit',
            )
          ];
        }
      );
  }
}
/*class cStorage extends StatefulWidget {
  const cStorage({Key? key}) : super(key: key);

  @override
  State<cStorage> createState() => _CounterStorage();
}
*/
class CounterStorage  {
 // const CounterStorage({required this.filename});

  String filename = "";
  String adroidDir = "/storage/emulated/0/Documents";
  String winDir = "c:/srtc";

  Future<String> getFileName() async {
    return await this.filename;
  }

  Future<void> setFName(String fn) async
  {
    this.filename = fn;
  }

  Future<String> get _localPath async {

    // if (await Permission.manageExternalStorage.isPermanentlyDenied) {
    //   openAppSettings();
    // }

    //final directory = await getExternalStorageDirectory();
    //final directory = await getExternalStorageDirectory();
    //await getExternalStorageDirectory();
    //Directory("/assets/assets/");
    //final directory = await Directory("/datas/");

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
          final directory = await Directory(this.winDir);
          if ( !directory.existsSync() )
            {
              final directory = await Directory.current;
              print("bub");
              print(directory.path as String);
              return directory.path;
            }
          return directory.path;
      }
    //  if( Platform.isAndroid ){
    //   final directory = await getApplicationDocumentsDirectory();
    //   return directory.path;
    // }


  }


  Future<File> get _localFile async {
    DateTime today = DateTime.now();
    String dateStr = "${today.year}_${today.month}_${today.day}";
     final path = await _localPath;
      final fn = this.filename;
      String allpath = "$path/"+"$fn"+"_"+"$dateStr"+".csv";
      return File(allpath);
    }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);

    } catch (e) {
      print("nincs!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      return 0;
    }
  }

  Future<int> writeMeterData(String meterdata) async {
    final file = await _localFile;
    try{
       if ( file.existsSync() == true ){
        file.writeAsString('$meterdata\n', mode: FileMode.append, encoding: SystemEncoding());
        print("van");
      }
        else
          {
            file.writeAsString('$meterdata\n', encoding: SystemEncoding());
            print("nincs");
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
    print("write");
  }

  Future<String> getPath() async {
    final f = await _localPath;

    return f;
  }

}

