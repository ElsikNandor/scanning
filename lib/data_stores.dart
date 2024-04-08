import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
//class dataStores{

int rCount = 0;

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
      print("dataRead: " + this.datapath);

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
      String dateStr = "_";//"${today.year}_${today.month}_${today.day}";
      final path = await _localPath;
      final fn = this.ordernumber;
      String allpath = "$path"+"$fn.csv";
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
  String dirPath = "C:/orders/"; //alapértelmezett
  String orderNumber = "0";
  int rows = 0;
  List<FileSystemEntity> _folders = [];

  void setDir( String dirPath )
  {
    this.dirPath = dirPath;
    //print("ADATOK: " + dataStore);
  }


  Future<void> getDir() async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = this.dirPath;
    //String pdfDirectory = '$dir/';
    final myDir = new Directory(dir);
    //setState(() {
      _folders = myDir.listSync(recursive: true, followLinks: false);
    //});

  }


  bool orderDirExists(String orderNumber)
  {
    String dirPath = this.dirPath;
    this.orderNumber = orderNumber;
    FileSystemEntity fullpath = new File(dirPath.toString() + "" + orderNumber + ".csv");
    //getDir();

    final found = _folders.where((element) {
      print("element: ");
      print(element.toString());
      return  element.path == fullpath.path;
    });
    print("folders: ");
    print(_folders);
    print("fullpath: ");
    print(fullpath);
    print("found: ");
    print(found.toString());
    
    if (found.isNotEmpty) {
      print('Találat: ${found.first}');
      return true;
    }
    else
      {
        print("Nincs találat.");
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
    print("Converter set");
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
    Map<String, String> rowsData = {"-" : "-"};

    if( this.row.length < 1 )
      {
        return rowsData;
      }

    if( this.owner == "Főgáz") {
      print("Főgáz Converter");
      rowsData["sort_prod_num"] = this.row.split(";")[0];
      rowsData["order_num"] = this.row.split(";")[1];
      rowsData["long_prod_num"] = this.row.split(";")[3];
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
    int counter = 0;
    Map<dynamic,dynamic> dataMap ;
    Map<String, String> meterData;
    Map<int, String> rowData = {0:"l"};
    print("adat hossza: " +datalength.toString());
    for( i = 0 ; i < datalength; i++ )
      {
        if( i % 61 == 0)
          {
            print(rows.toString());
            //rowData = { rows : this.dataStore[i]};
            rowData[rows] = this.dataStore[i];
            rows++;

          }

/*        if( counter == 7)
          {
            meterData = { "sort_productnumber" : "" };
          }

        counter++;
*/
      }

    return rowData;
  }

  int getRows()
  {
    return rows;
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