import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'screenargument.dart';
import 'myclasses.dart';

String argString = "Username";
String meterType = "";
class readingData extends StatefulWidget {
  const readingData({Key? key}) : super(key: key);

  @override
  State<readingData> createState() => _readingDataState();
}

class _readingDataState extends State<readingData> {
  String _data = "";
  Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/metertype.txt');
    setState(() {
      _data = loadedData;
    });
  }
  void initState() {
    super.initState();
    _loadData();
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    int metersCount = _data.split(",").length.toInt();
    argString = args.message;
    //final ButtonStyle style = TextButton.styleFrom(textStyle:  Theme.of(context).colorScheme.onPrimary,);
    return Scaffold(
      appBar: AppBar(
        title: Text(argString.split(";")[0] + " - Összegzés: "),
        actions: <Widget>[
        TextButton.icon(
        icon: const Icon(Icons.cabin, color: Colors.white,) ,
        onPressed: () { Navigator.pushReplacementNamed(context, '/'); },
        label: const Text( "" ),
      )]
      ),
      body:Center(
        child:
      Column (
      children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(0.0),
            alignment: Alignment.centerLeft,
            width: 500,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(width: 1,color: Colors.black,),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(
              style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold),
                "Gyártási szám: " + argString.split(";")[1]
            ),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.all(0.0),
            alignment: Alignment.centerLeft,
            width: 500,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(width: 1,color: Colors.black,),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(
                style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold),
                "Gyártó: "+ argString.split(";")[2]
            ),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.all(0.0),
            alignment: Alignment.centerLeft,
            width: 500,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(width: 1,color: Colors.black,),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(
                style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold),
                "Számláló állás: ---"//+ argString.split(";")[2]
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(150, 40),
            ),
            onPressed: () {
              //myReset();
              Navigator.pushReplacementNamed(context, '/');
            },
            child: Text("Mentés"),
          )
        ],
      ),
      ]
      ),
      ),
    );
  }
}

Widget LogoutButton(BuildContext context) {
  //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
  return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(150, 40),
        ),
        onPressed: () {
          //myReset();
          Navigator.pushReplacementNamed(context, '/');
        },
        child: Text("Logout"),
      )
  );


  /*Card(
      child: SizedBox(
        height: 100,
        child: Center(child: Text(text)),
      ),
    );*/
}



