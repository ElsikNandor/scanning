import 'package:flutter/material.dart';
import 'package:scanning/mtype.dart';
import 'screenargument.dart';
import 'main.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

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
class CounterStorage {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;

  }

  Future<File> get _localFile async {
    final path = await _localPath;
      return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);

    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }

  Future<void> copyToAssets() async {
    final File file = await _localFile;
    file.copy("${_localPath}/ize/");
    print("write");
  }

}

