import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanning/yof.dart';
import 'dart:async';
import 'constnum.dart';
import 'mtype.dart';
import 'readingdata.dart';
import 'myclasses.dart';
import 'package:permission_handler/permission_handler.dart';
import 'counting_position.dart';
import 'gear_pairs.dart';
import 'gears_map.dart';
import 'owner.dart';

fileManip fmanip = new fileManip();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => const HomePage(),
        '/constnum' : (context) => const ConstNum(),
        '/mtype' : (context) => const mType(),
        '/readingData' : (context) => const readingData(),
        '/yof' :  (context) => const yearOfManufacture(),
        '/countpos' : (context) => const CountPos(),
        '/gearpairs' : (context) => const GearPairs(),
        '/owners' : (context) => const mOwner(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _data = "";
  String hhh = "---";
  String path = "dirs";

  Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/data.txt');
    setState(() {
        _data = loadedData;
    });
  }

  Future<void> requestPermission() async {
    final permission = Permission.manageExternalStorage;
    var status = await Permission.manageExternalStorage.status;
    bool isShown = await Permission.manageExternalStorage
        .shouldShowRequestRationale;
    PermissionStatus _permissionStatus = PermissionStatus.denied;

    await Permission.manageExternalStorage.request();
    if (status.isDenied || status.isGranted == false) {
      hhh = "Permission is denied :(";
      await Permission.manageExternalStorage.request();
      //hhh += " req";
      if (await Permission.manageExternalStorage
          .request()
          .isGranted ||
          await Permission.storage
              .request()
              .isGranted ) {
        PermissionStatus permissionStatus =
        await Permission.manageExternalStorage.status;
        //hhh += " req granted";
        setState(() {
          _permissionStatus = permissionStatus;
          //hhh = _permissionStatus.toString();
        });
      }

      //openAppSettings();
    }
    else{
      setState(() {
        hhh = "ok";
      });

    }

  }

  void initState() {
    super.initState();
    requestPermission();
    _loadData();
      setState(() {

       });
  }


  @override
  Widget build(BuildContext context) {
    int nameCount = _data.split(",").length.toInt();
    return Scaffold(
      appBar: AppBar(
        title: Text("Adatrögzítő választó"),
        actions: [myMenu(username : "")],
      ),
      body: Scrollbar( child:
        GridView.count(
            primary: false,
        padding: const EdgeInsets.all(50),
        mainAxisSpacing: 20,
    crossAxisSpacing: 20,
    crossAxisCount: 5,
     children:
    List.generate(nameCount, (index) {
    return ItemWidget(text:  _data.split(",")[index],
        path: '/owners',
      data: _data.split(",")[index], user: _data.split(",")[index]
    );

    }),
      ),
      ),
     );
  }
}

