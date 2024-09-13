import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanning/data_stores.dart';
import 'package:scanning/gen_barcode.dart';
import 'package:scanning/one_meter_data.dart';
import 'package:scanning/yof.dart';
import 'dart:async';
import 'constnum.dart';
import 'mtype.dart';
import 'readingdata.dart';
import 'myclasses.dart';
import 'package:permission_handler/permission_handler.dart';
import 'counting_position.dart';
import 'gear_pairs.dart';
import 'gear_pairs_metrix_1.dart';
import 'gear_pairs_metrix_2.dart';
import 'gear_pairs_metrix_3.dart';
import 'gears_map.dart';
import 'owner.dart';
import 'order_number.dart';
import 'notgood_meter.dart';
import 'package:window_size/window_size.dart';
import 'dataexport.dart';
import 'check_network.dart';
import 'dataread_test.dart';
import 'dart:io';
import 'connectivity_controller.dart';
import 'order_controller.dart';
import 'meter_controller.dart';
import 'controller_test.dart';
import 'package:fullscreen_window/fullscreen_window.dart';

fileManip fmanip = new fileManip();
String mainakarmi = '1';
convertData convert = convertData();

orderDirRead orderDir = orderDirRead();

int orderCountGlobal = 0;
readSavedData rsDataClassGood = readSavedData();
readSavedData rsDataClassNotGood = readSavedData();
int rcDataGoodCount = 0;
int rcDataNotGoodCount = 0;
dataRead orderDataRead = dataRead();
ownersDataConverter ownConv = ownersDataConverter();
String dataFilePath = "";
OrderController orderC = OrderController();
MeterController meterController = MeterController();
//dataFile = ""
List<String> readMeterData = ["-"];
bool orderCheck = false;
String saveDirName = "";
Map<String, String> ownerMap = {"Főgáz" : "FG",
  "Égáz" : "ED",
  "EON" : "EON",
  "Tigáz" : "4",
  "Magáz" : "MG"};
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  runApp(const MyApp_prev());
}

class MyApp_prev extends StatefulWidget {
  const MyApp_prev({Key? key}) : super(key: key);

  @override
  State<MyApp_prev> createState() => MyApp();
}


class MyApp extends State<MyApp_prev> {
  String screenSizeText = "";
  Future<String> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/savedirname.txt');
    setState(() {
      saveDirName = loadedData.split(";")[0]+":\\"+loadedData.split(";")[1];
      dataFilePath = saveDirName+"/orders/";
    });
    return saveDirName;
  }

  void setFullScreen(bool isFullScreen) {
    FullScreenWindow.setFullScreen(isFullScreen);
  }
  void showScreenSize(BuildContext context) async {
    Size logicalSize = await FullScreenWindow.getScreenSize(context);
    Size physicalSize = await FullScreenWindow.getScreenSize(null);
    setState(() {
      screenSizeText =
      "Screen size (logical pixel): ${logicalSize.width} x ${logicalSize.height}\n";
      screenSizeText +=
      "Screen size (physical pixel): ${physicalSize.width} x ${physicalSize.height}\n";
    });
  }
  void initState() {
    setFullScreen(true);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    _loadData();
    _loadData().then((value) {
      dataFilePath = value.toString()+ "/orders/";
      print(value);
      return value;
    });

    readMeterData = ["-"];
    orderC.init();

    setState(() {
      spn = "1234";
      pn = "123456";
      on = "10001";
    });



    print(orderC.isorder);


  }




   @override
  Widget build(BuildContext context) {

     orderDir.setDir(dataFilePath);
     orderDir.getDir();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Application',
      theme: ThemeData(
        useMaterial3: false,
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
        '/gearpairs_metrix1' : (context) => const GearPairsMetrix1(),
        '/gearpairs_metrix2' : (context) => const GearPairsMetrix2(),
        '/gearpairs_metrix3' : (context) => const GearPairsMetrix3(),
        '/owners' : (context) => const mOwner(),
        '/order_number' : (context) => OrderNumber(storage: dataRead()),
        '/notgood_meter' : (context) => const NotGoodMeter(),
        '/dataexport' : (context) => const dataExport(),
        '/network' : (context) => const NetworkCheckPage(title: "Hálózat ellenőrzés."),
        '/barcode' : (context) => const Gen_BarCode(),
        '/meterstoragetest' : (context) => const One_Meter_Data(),
        '/dataReadTest' : (context) => const dataReadTest(),
        '/test' : (context) => const FlutterDemo2(),



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

  ConnectivityController connectivityController = ConnectivityController();

  ValueNotifier<bool> network_state = ValueNotifier(false);

  Future<void> setTitlePlatform() async{
    if (Platform.isWindows)
    {
      setWindowTitle("Adatrögzítés");
    }
  }
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
        });
      }
    }
    else{
      setState(() {
        hhh = "ok";
      });

    }

  }

  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    connectivityController.init();
    super.initState();
    requestPermission();
    _loadData();
    setTitlePlatform();
      setState(() {
        network_state = connectivityController.isConnected;
       });
  }


  @override
  Widget build(BuildContext context) {
    int nameCount = _data.split(",").length.toInt();
    double boxWith = MediaQuery.of(context).size.width-400;
    return Scaffold(
      appBar: AppBar(
        title: Text("Adatrögzítő választó"),
        actions: [myMenu(username : "", message: "", mlogin: 1,)],
      ),
      body:
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
            children:

            [
              /*SizedBox(
                height: 50,
                child: ConnectionAlert(),
              ),*/

              SizedBox(
              height: 80,
              child: Image.asset('assets/logo.jpg'),
              ),
                SizedBox(
                  height: 500,
                  width: nameCount < 5 ? boxWith/2 : boxWith,
                 child:
                  GridView.builder(
                  primary: false,
                  padding: const EdgeInsets.all(10),

                    itemCount: nameCount,
                  itemBuilder: (context, index) =>
                     Container(
                       height: 10,
                      //width: 130,
                      child:  ItemWidget(text:  _data.split(",")[index],
                          path: '/owners',
                          data: _data.split(",")[index], user: _data.split(",")[index],
                        lastSavedNum: "",
                      )
                     ),
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: nameCount < 5 ? nameCount : 5,//_crossAxisCount,
                      crossAxisSpacing: 20,//_crossAxisSpacing,
                      mainAxisSpacing: 50,//_mainAxisSpacing,
                      childAspectRatio: 10,//_aspectRatio,
                      mainAxisExtent: nameCount < 5 ? (boxWith)/(nameCount*2) : (boxWith)/(nameCount),

                    ),
                  //}),
                )
                ),

              ]
          )
     );
  }
}

