// import 'dart:html';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'myclasses.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:platform/platform.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: xd()
        // FlutterDemo(storage: CounterStorage("l")),
    ),
  );
}

class xd extends StatefulWidget {
  const xd({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class FlutterDemo extends StatefulWidget {
  const FlutterDemo({super.key, required this.storage});

  final CounterStorage storage;

  @override
  State<FlutterDemo> createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  String _counter = "";
  String hhh = "---";
  String path = "dirs";
  bool _allowWriteFile = false;
  @override
  void initState() {
    super.initState();
    requestPermission();
    fWrite();
   //  widget.storage.readCounter().then((value) {
   //    setState(() {
   //      _counter = "";
   //    });
   //  });
   // widget.storage.getPath().then((value) {
   //    setState(() {
   //      path = value;
   //    });
   //  });
  }

  Future<void> requestPermission() async {
    final permission = Permission.manageExternalStorage;
    var status = await Permission.manageExternalStorage.status;
    bool isShown = await Permission.manageExternalStorage
        .shouldShowRequestRationale;
    PermissionStatus _permissionStatus = PermissionStatus.denied;


    if (status.isDenied || status.isGranted == false) {
      hhh = "Permission is denied :(";
      await Permission.manageExternalStorage.request();
      hhh += " req";
      if (await Permission.manageExternalStorage
          .request()
          .isGranted ||
          await Permission.storage
              .request()
              .isGranted ) {
        PermissionStatus permissionStatus =
        await Permission.manageExternalStorage.status;
        hhh += " req granted";
        setState(() {
          _permissionStatus = permissionStatus;
          hhh = _permissionStatus.toString();
        });
      }

      //openAppSettings();
    }
    else{
       hhh = "ok";
    }

  }
  // Future<File> _incrementCounter() {
  //   setState(() {
  //     _counter = "";
  //     //widget.storage.copyToAssets();
  //   });
  //
  //   // Write the variable as a string to the file.
  //   widget.storage.writeMeterData("l");
  //   return widget.storage.getPath();
  // }

  Future<void> fWrite() async  {
    var file = await File('./file.txt');
    var sink = await file.openWrite();
    sink.write('FILE ACCESSED ${DateTime.now()}\n');

    // Close the IOSink to free system resources.
    sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading and Writing Files'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
            ),
            Text(hhh),
            Text(path),
          ],
        )


      ),
      // floatingActionButton: FloatingActionButton(
      //   // onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}