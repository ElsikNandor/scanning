import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChannels, rootBundle;
import 'package:scanning/order_number.dart';
import 'dart:async';
import 'screenargument.dart';
import 'myclasses.dart';
import 'main.dart';

final _formKey = GlobalKey<FormState>();
String argString = "Username";
String meterType = "";
class mType extends StatefulWidget {
  const mType({super.key});

  @override
  State<mType> createState() => _mTypeState();
}

class _mTypeState extends State<mType> {
  String _data = "";

  Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/metertype.txt');
    setState(() {
      _data = loadedData;
    });
  }
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    _loadData();
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    int metersCount = _data.split(";").length.toInt();
    //print("count: " + metersCount.toString());
    //print(_data);
  print("reading: " + readMeterDataMap.toString());
    //argString = args.message;
    String blank = "-";
    return Scaffold(
      appBar: AppBar(
        title: Text("Típus kiválasztása | Adatrögzítő: ${readMeterDataMap["user"].toString() } | Megrendelő: ${ readMeterDataMap["owner"] }"),
        actions: <Widget>[
        myMenu(username: argString.split(";")[0], message: argString, mlogin: 0)
        ]
      ),
      body: ScrollbarTheme(
        //thumbVisibility: true,
        //interactive: true,
        //controller: ScrollController(),
        data: ScrollbarTheme.of(context).copyWith(thumbVisibility: MaterialStateProperty.all(true)),
        child:
      GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 8,
        children:
        List.generate(metersCount, (index) {
          return ItemWidget(text:  _data.split(";")[index],
            //path: _data.split(",")[index] == "Metrix" ? '/gearpairs_metrix1' : '/gearpairs',
            path: actualOwner == "MG" ?  '/countpos' : '/countpos' , // MG át lett nevezve OT-re nem kell az MG feltétel 2024.11.11
            //path: '/yof',
            //'/countpos',
            data: _data.split(";")[index] ,
            user: readMeterDataMap['user'].toString(),
            //data: actualOwner == "MG" ? '$argString;${_data.split(";")[index]}' : argString+';'+_data.split(";")[index]+";"+blank+";"+blank+";"+blank, user: argString.split(";")[0],
            page : "mtype",
            lastSavedNum: "-",
          );
        }),

      ),
    )
    );
  }
}
/*if(args.message.split(";")[1] == "Tigáz")
{
Navigator.pushReplacementNamed(context, '/mtype',
arguments: ScreenArguments(userName, userName+";"+meterNumber, "") );
}
else
{
sendMessage = userName+";"+meterNumber+";"+blank+";"+blank+";"+blank;
Navigator.pushReplacementNamed(context, '/readingData',
arguments: ScreenArguments(userName, sendMessage, "") );
}
*/
/*if( args.message.split(";")[3] == "Metrix")
{
Navigator.pushReplacementNamed(context, '/gearpairs_metrix1',
arguments: ScreenArguments(userName, userName+";"+meterNumber, "") );
}
else
{
Navigator.pushReplacementNamed(context, '/gearpairs',
arguments: ScreenArguments(userName, userName+";"+meterNumber, "") );
}*/

Widget LogoutButton(BuildContext context) {
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

}

class constInputForm extends StatefulWidget {
  const constInputForm({super.key});
  @override
  constInputFormState createState() {
    return constInputFormState();
  }
}

class constInputFormState extends State<constInputForm> {
   @override
  Widget build(BuildContext context) {
    double itmp = 0;
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Gázmérő típusa',
              border: OutlineInputBorder(),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'A mező nem lehet üres!';
              }
              meterType = value;
              return null;
            },
          ),

        ],
      ),
    );
  }
}