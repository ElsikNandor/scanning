import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

//var gears ={ {"32/40", "white", "1"}, {"11", "kk", "2"} };
  Map<String, dynamic> filmStarWars = {"title": "Star Wars",
    "year": 1977};
  Map<String, dynamic> filmEmpire   = {"title": "The Empire Strikes Back",
    "year": 1980};
  Map<String, dynamic> filmJedi     = {"title": "The Return of the Jedi",
    "year": 1983};


//List<gasMeterGear> gears = [gasMeterGear(gear: "32/40", color: "white", hole: "1"),
//];

class fileManip{

  Future<String> readItronGears() async {

      final contents = await rootBundle.loadString('assets/itron_gears.txt');
      //print(contents);
      return contents;
    }

  Future<String> readMetrixGears() async {

    final contents = await rootBundle.loadString('assets/itron_gears.txt');

    return contents;
  }

  Future<List<gasMeterGear>> loadItronGears() async{
    List<gasMeterGear> gears = [];
      //gasMeterGear(gear: "32/40", color: "white", hole: "1"),
    //];
    String data = "";
    String readedGears = await readItronGears();
    //readedGears = readedGears;
    int count = readedGears.split(";").length.toInt();
    print("count: $count");
    for( var i = 0; i < count; i++ )
    {
     // for( var j = 0; j < 2; i++ ) {
        data = readedGears.split(";")[i];
        if( i > 0 ) data = data.substring(2);
        gears.add(gasMeterGear(gear: data.split(",")[0], color: data.split(",")[1], hole: data.split(",")[2]));
     // }
    }
    print(gears[3].color);
    return gears;
  }

  Future<String> _loadData() async {
    final String loadedData = await rootBundle.loadString('assets/data.txt');


    return loadedData;
  }


}

//  print(currentFilm);
 // print(currentFilm['title']);
var json = {
  'user': ['Lily', 13]
};

class gasMeterGear {
  gasMeterGear({
  required this.gear,
    required this.color,
    required this.hole
  });

  String gear = "x1";
  String color = "x2";
  String hole = "x3";
}
