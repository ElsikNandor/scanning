import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'screenargument.dart';
import 'myclasses.dart';
import 'gears_map.dart';

final _formKey = GlobalKey<FormState>();
String argString = "Username";
String meterType = "";
class GearPairs extends StatefulWidget {
  const GearPairs({Key? key}) : super(key: key);

  @override
  State<GearPairs> createState() => _GearPairsState();
}

class _GearPairsState extends State<GearPairs> {
  String _data = "";
  Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/yofs.txt');
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

  //gasMeterGear g = gears[0];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    int metersCount = _data.split(",").length.toInt();
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
      body:
        Column(
          children: [
            Text( " ize : " + gears[0].gear  ),
          ]

        )
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
    );
  }
}
