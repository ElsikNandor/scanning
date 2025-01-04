import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';

int rCount = 0;

class meterDataCl
{
  List<String> md = [];

  meterDataCl(
    {
      required this.md
    }  );
}

class dataChange extends ChangeNotifier {
  late meterDataCl dataList;

  void addDataList({required List<String> dataL}){
    dataList.md = dataL;
    notifyListeners();
  }
}

class meterDatas{
  String sort_productnumber = "";
  String productnumber = "";
  String ordernumber = "";

  Map<String, String> meter = {};

  void add_MeterDatas(String sortProductnumber, String productnumber, String ordernumber)
  {

    sort_productnumber = sortProductnumber;
    this.productnumber = productnumber;
    this.ordernumber = ordernumber;

  }


  String getSortProductNumber()
  {
    return sort_productnumber;
  }

  String getProductNumber()
  {
    return productnumber;
  }

  String getOrderNumber()
  {
    return ordernumber;
  }


}

class dataRead
{
    String ordernumber = "";
    String datapath = "";
    String owner = "";

    void addDataFile( String datapath, String ordernumber, String owner)
    {
      this.ordernumber = ordernumber;
      this.datapath = datapath;
      this.owner = owner;
    }

    Future<String> get _localPath async {

      final directory = Directory(datapath); // c:/src
        if ( !directory.existsSync() )
        {
          final directory = Directory.current;
          return directory.path;
        }
        return directory.path;
      }

    Future<File> get _localFile async {
      final path = await _localPath;
      final fn = ordernumber;
      String allpath = "$path${fn}_$owner.csv";

      print("allpath new");
      print(allpath);
      return File(allpath);
    }

    Future<List<String>> readFile() async {
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsLines();

     return contents;
    }



    String readSavedFile()
    {
      var data = "";
      //readFile().then((value) => data = value);

      return data;
    }

}

class orderDirRead
{
  String dirPath = ""; //alapértelmezett
  String orderNumber = "0";
  int rows = 0;
  List<FileSystemEntity> folders = [];

  void setDir( String dirPath )
  {
    this.dirPath = dirPath;
    //print("ADATOK: " + dataStore);
  }


  Future<void> getDir() async {
  //  final directory = await getApplicationDocumentsDirectory();
    final dir = dirPath;
    //String pdfDirectory = '$dir/';
    final myDir = Directory(dir);
    //setState(() {
      //_folders = myDir.listSync(recursive: true, followLinks: false);
    folders = myDir.listSync(recursive: true, followLinks: false);

    //});

  }


  bool orderDirExists(String orderNumber, String ownerID)
  {
    String dirPath = this.dirPath;
    this.orderNumber = orderNumber;
    FileSystemEntity fullpath = File("$dirPath${orderNumber}_$ownerID.csv");
    print(fullpath);
    //getDir();

    final found = folders.where((element) {

      return  element.path == fullpath.path;
    });

    if (found.isNotEmpty) {
      return true;
    }
    else
      {
        return false;
      }

    return false;
  }

}

class ownersDataConverter
{
  String row = "";
  String owner = "Főgáz";

  void setDatas(String row, String owner)
  {
    this.row = row;
    this.owner = owner;
  }

  String getRow()
  {
    return row;
  }

  String getOwner()
  {
    return owner;
  }

  Map<String, String> convertData()
  {
    Map<String, String> rowsData = {};

    if( row.isEmpty )
      {
        return rowsData;
      }

    if( owner == "FG") {
      try {
        rowsData["sort_prod_num"] = row.split(";")[0];
        rowsData["order_num"] = row.split(";")[1];
        rowsData["long_prod_num"] = row.split(";")[3];
      }
      catch (e) {

        return rowsData = {"error" : "owner"};

      }
    }

    if(owner == "ED") {
      try {
        rowsData["sort_prod_num"] = row.split(";")[0];
        rowsData["order_num"] = row.split(";")[1];
        rowsData["long_prod_num"] = row.split(";")[3];
      }
      catch (e) {

        return rowsData = {"error" : "owner"};

      }
    }



    if( owner == "EON" ) {
      //print("EON Converter");
      try {
        rowsData["sort_prod_num"] = row.split(";")[0];
        rowsData["order_num"] = row.split(";")[1];
        rowsData["long_prod_num"] = row.split(";")[3];
      }
      catch (e) {

        return rowsData = {"error" : "owner"};

      }
    }

    if( owner == "4" ) {
      //print("EON Converter");
      try {
        rowsData["sort_prod_num"] = row.split(";")[6];
        rowsData["order_num"] = row.split(";")[2];
        rowsData["long_prod_num"] = row.split(";")[9];
      }
      catch (e) {

        return rowsData = {"error" : "owner"};

      }
    }
    if( owner == "OT" ) {
      //print("EON Converter");
      try {
        rowsData["sort_prod_num"] = "null";
        rowsData["order_num"] = "null";
        rowsData["long_prod_num"] = "null";
      }
      catch (e) {

        return rowsData = {"error" : "owner"};

      }
    }
    return rowsData;
  }



}

class convertData
{
  String dataStore = "";
  int rows = 0;

  void addDataStore( String dataStore )
  {
    this.dataStore = dataStore;
    //print("ADATOK: " + dataStore);
  }


  Map<int, String> convert()
  {
    rows = 0;
    int datalength = dataStore.length;
    int i = 0;
     Map<int, String> rowData = {0:"l"};
    print("adat hossza: $datalength");
    for( i = 0 ; i < datalength; i++ )
      {
        if( i % 61 == 0)
          {
            print(rows.toString());

            rowData[rows] = dataStore[i];
            rows++;

          }

      }

    return rowData;
  }

  int getRows()
  {
    return rows;
  }

}


class readSavedData
{
  String ordernumber = "";
  String datapath = "";
  String owner = "";

  bool isgood = false;

  void addDataFile( String datapath, String ordernumber, bool isgood, String owner)
  {
    this.ordernumber = ordernumber;
    this.datapath = datapath;
    this.isgood = isgood;
    this.owner = owner;
  }

  Future<String> get _localPath async {


    final directory = Directory(datapath); // c:/src
    if ( !directory.existsSync() )
    {
      final directory = Directory.current;
      //print(directory.path as String);
      return directory.path;
    }
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    final fn = ordernumber;
    String fnparam = "";

    if(isgood)
      {
        fnparam = "meterdata_good_${fn}__";
      }
    else
      {
        fnparam = "meterdata_notgood_${fn}__";
      }

    String allpath = "$path/""$fnparam.csv";

    return File(allpath);
  }

  Future<List<String>> readFile() async {
    final file = await _localFile;

    List<String> contents = [];

    if( file.existsSync() )
      {
        contents = await file.readAsLines();
      }
    else
      {
        contents = [];
      }
print(file.path);


    return contents;
  }



  int getRowCountFile( List<String> data)
  {
    if( data.isEmpty) {
      return 0;
    }

    return data.length;
  }

}


//fontos elem a használathoz
/*String saveDirName = "";
Future<void> _loadData() async {
  final loadedData = await rootBundle.loadString('assets/savedirname.txt');
  setState(() {
    saveDirName = loadedData.split(";")[0]+":\\"+loadedData.split(";")[1];
  });
}*/