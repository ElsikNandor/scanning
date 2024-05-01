import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

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

  void add_MeterDatas(String sort_productnumber, String productnumber, String ordernumber)
  {

    this.sort_productnumber = sort_productnumber;
    this.productnumber = productnumber;
    this.ordernumber = ordernumber;

  }


  String getSortProductNumber()
  {
    return this.sort_productnumber;
  }

  String getProductNumber()
  {
    return this.productnumber;
  }

  String getOrderNumber()
  {
    return this.ordernumber;
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

      final directory = await Directory(this.datapath); // c:/src
        if ( !directory.existsSync() )
        {
          final directory = await Directory.current;
          return directory.path;
        }
        return directory.path;
      }

    Future<File> get _localFile async {
      final path = await _localPath;
      final fn = this.ordernumber;
      String allpath = "$path"+"$fn.csv";
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
    final dir = this.dirPath;
    //String pdfDirectory = '$dir/';
    final myDir = new Directory(dir);
    //setState(() {
      //_folders = myDir.listSync(recursive: true, followLinks: false);
    folders = myDir.listSync(recursive: true, followLinks: false);

    //});

  }


  bool orderDirExists(String orderNumber)
  {
    String dirPath = this.dirPath;
    this.orderNumber = orderNumber;
    FileSystemEntity fullpath = new File(dirPath.toString() + "" + orderNumber + ".csv");
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
    return this.row;
  }

  String getOwner()
  {
    return this.owner;
  }

  Map<String, String> convertData()
  {
    Map<String, String> rowsData = {};

    if( this.row.length < 1 )
      {
        return rowsData;
      }

    if( this.owner == "1" || this.owner == "2") {
      try {
        rowsData["sort_prod_num"] = this.row.split(";")[0];
        rowsData["order_num"] = this.row.split(";")[1];
        rowsData["long_prod_num"] = this.row.split(";")[3];
      }
      catch (e) {

        return rowsData = {"error" : "owner"};

      }
    }

    if( this.owner == "3" ) {
      //print("EON Converter");
      try {
        rowsData["sort_prod_num"] = this.row.split(";")[0];
        rowsData["order_num"] = this.row.split(";")[1];
        rowsData["long_prod_num"] = this.row.split(";")[3];
      }
      catch (e) {

        return rowsData = {"error" : "owner"};

      }
    }

    if( this.owner == "4" ) {
      //print("EON Converter");
      try {
        rowsData["sort_prod_num"] = this.row.split(";")[6];
        rowsData["order_num"] = this.row.split(";")[2];
        rowsData["long_prod_num"] = this.row.split(";")[9];
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
    int datalength = this.dataStore.length;
    int i = 0;
     Map<int, String> rowData = {0:"l"};
    print("adat hossza: " +datalength.toString());
    for( i = 0 ; i < datalength; i++ )
      {
        if( i % 61 == 0)
          {
            print(rows.toString());

            rowData[rows] = this.dataStore[i];
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


    final directory = await Directory(this.datapath); // c:/src
    if ( !directory.existsSync() )
    {
      final directory = await Directory.current;
      //print(directory.path as String);
      return directory.path;
    }
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    final fn = this.ordernumber;
    String fnparam = "";

    if(isgood)
      {
        fnparam = "meterdata_good_"+fn+"__";
      }
    else
      {
        fnparam = "meterdata_notgood_"+fn+"__";
      }

    String allpath = "$path/"+"$fnparam.csv";

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
        contents = ["0"];
      }
print(file.path);


    return contents;
  }



  int getRowCountFile( List<String> data)
  {
    if( data[0] == "0")
      return 0;

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