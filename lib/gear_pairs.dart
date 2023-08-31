import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'screenargument.dart';
import 'myclasses.dart';
import 'gears_map.dart';
import 'package:flutter/foundation.dart';

final _formKey = GlobalKey<FormState>();
String argString = "Username";
String meterType = "";

class GearPairs extends StatefulWidget {
  const GearPairs({Key? key}) : super(key: key);

  @override
  State<GearPairs> createState() => _GearPairsState();
}

class _GearPairsState extends State<GearPairs> {
  fileManip fmanip = new fileManip();
  List<gasMeterGear> gears = [];
  void initState() {
    super.initState();
    //gears = loadGearList();
    loadGearList().then((value){
      setState(() {
        gears = value;
      });
    });
    setState(() {

        //gears = gearsdata;
    });
  }

  Future<List<gasMeterGear>> loadGearList() async {
    final gear = await fmanip.loadItronGears();
    print("f" + gears.length.toString());
    return gear;
  }
  //gasMeterGear g = gears[0];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as ScreenArguments;
    argString = args.message;
    final formkey = GlobalKey<FormState>();
    //final ButtonStyle style = TextButton.styleFrom(textStyle:  Theme.of(context).colorScheme.onPrimary,);
    return Scaffold(
      appBar: AppBar(
          title: Text(argString.split(";")[0]),
          actions: <Widget>[
            myMenu(username: argString.split(";")[0])
          ]
      ),
      body: //Text(gears.length.toString())
      //Text(gears[0].color + gears[1].color + gears[2].color + gears[3].color),
      Scrollbar(child:
      GridView.count(
        primary: false,
        padding: const EdgeInsets.all(30),
        mainAxisSpacing: 30,
        crossAxisSpacing: 30,
        crossAxisCount: 5,
        children:
        List.generate(gears.length, (index) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(20, 20),
              maximumSize: Size(50, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(130.0)
              ),
                side: const BorderSide(
                  width: 5.0,
                  color: Colors.black,
                ),
              primary: Color( int.parse(gears[index].color, radix: 16) ),
              onPrimary: gears[index].color == 'ff000000' ? Color(0xffffffff) : Color(0xff000000)
            ),
            onPressed: () {
              //myReset();
              //Navigator.pushReplacementNamed(context, path,
              //  arguments: ScreenArguments(user, data));
            },
            child: Text(index.toString() + gears[index].gear + " " + gears[index].color + " " +
                gears[index].hole),
          );
        }),
      ),
      ),
    );
  }
        // Column(
        //   children: [
        //     Text( " ize : " + gears[1].color  ),
        //   ]
        //
        // )
      /*Scrollbar( child:
      GridView.count(
        primary: false,
        padding: const EdgeInsets.all(50),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: 5,
        children:
        List.generate(gears.length, (index) {
          var g = gears[0];
          return ItemWidget(text: index.toString(),
              path: '/countpos',
              data: argString+';'+_data.split(",")[index], user: argString.split(";")[0]
          );
        }),
      ),
      ),*/
}
