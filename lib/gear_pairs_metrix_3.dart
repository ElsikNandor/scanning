import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'screenargument.dart';
import 'myclasses.dart';
import 'gears_map.dart';
import 'package:flutter/foundation.dart';

String argString = "Username";
String meterType = "";

class GearPairsMetrix3 extends StatefulWidget {
  const GearPairsMetrix3({Key? key}) : super(key: key);

  @override
  State<GearPairsMetrix3> createState() => _GearPairsMetrix3State();
}

class _GearPairsMetrix3State extends State<GearPairsMetrix3> {
  fileManip fmanip = new fileManip();
  List<gasMeterGear> gears = [];
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    loadGearList().then((value){
      setState(() {
        gears = value;
      });
    });
    setState(() {
    });
  }

  Future<List<gasMeterGear>> loadGearList() async {
    final gear = await fmanip.loadMetrixGears("3");
   // print("f" + gears.length.toString());
    return gear;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as ScreenArguments;
    argString = args.message;
    String userN = argString.split(";")[0];
    final formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
          title: Text("Cserekerék kiválasztása | "
              + "Adatrögzítő: " + args.message.split(";")[0]
              + " | Megrendelő: " + args.message.split(";")[1]),
          actions: <Widget>[
            myMenu(username: argString.split(";")[0], mlogin: 0)
          ]
      ),
      body:
      Scrollbar(child:
        /*  Column(
            children: [
      Text("Metrix3"),
              SizedBox(
                width: 110,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Theme.of(context).colorScheme.onPrimary,
                    primary: Theme.of(context).colorScheme.primary,
                    minimumSize: Size(150,100),
                  )
                      .copyWith(elevation: ButtonStyleButton.allOrNull(0.0)
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pushReplacementNamed(context, "/readingData",
                          arguments: ScreenArguments(userN,
                              args.message.split(";")[0]+";"+
                              args.message.split(";")[1]+";"+
                              args.message.split(";")[2]+";"+
                              args.message.split(";")[3]+";"+
                              args.message.split(";")[4]+";"+
                              args.message.split(";")[5]+";"+
                              args.message.split(";")[6]+"/xx", ""));
                    });
                  },
                  child: Text("Tovább"),
                ),
              ),*/
      GridView.count(
        primary: false,
        padding: const EdgeInsets.all(30),
        mainAxisSpacing: 30,
        crossAxisSpacing: 30,
        crossAxisCount: 8,
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
              onPrimary: int.parse(gears[index].color, radix: 16) <= int.parse("ff713912", radix: 16) ? Color(0xffffffff) : Color(0xff000000)
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/readingData",
                  arguments: ScreenArguments(userN,
                                  args.message.split(";")[0]+";"+
                                  args.message.split(";")[1]+";"+
                                  args.message.split(";")[2]+";"+
                                  args.message.split(";")[3]+";"+
                                  args.message.split(";")[4]+";"+
                                  args.message.split(";")[5]+";"+
                                  args.message.split(";")[6]+"_"+gears[index].gear, ""));
            },
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(gears[index].gear),
                SizedBox(
                  height: 10,
                ),
                Text(int.parse(gears[index].hole) == 1 ? "o" : "o     o")
              ],
            )

          );
        }),
      ),
        //    ],
          //)
      ),

    );
  }

}
