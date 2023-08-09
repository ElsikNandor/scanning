import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'screenargument.dart';
import 'myclasses.dart';

final _formKey = GlobalKey<FormState>();
String argString = "Username";
String meterType = "";
class mType extends StatefulWidget {
  const mType({Key? key}) : super(key: key);

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
    final formkey = GlobalKey<FormState>();
    //final ButtonStyle style = TextButton.styleFrom(textStyle:  Theme.of(context).colorScheme.onPrimary,);
    return Scaffold(
      appBar: AppBar(
        title: Text(metersCount.toString()),
        actions: <Widget>[
        TextButton.icon(
        icon: const Icon(Icons.cabin, color: Colors.white,) ,
        onPressed: () { Navigator.pushReplacementNamed(context, '/'); },
        label: const Text( "" ),
      )]
      ),
      body: Scrollbar( child:
      GridView.count(
        primary: false,
        padding: const EdgeInsets.all(50),
        mainAxisSpacing: 30,
        crossAxisSpacing: 30,
        crossAxisCount: 4,
        children:
        List.generate(metersCount, (index) {
          return ItemWidget(text:  _data.split(",")[index],
            path: '/readingData',
            data: argString+';'+_data.split(",")[index],
          );
        }),
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
                //myReset();
                return 'A mező nem lehet üres!';
              }

              /*try {
                itmp = double.parse(value);
              } catch(_) {
                //myReset();
                return 'A mező csak számokat tartalmazhat!';
              }*/
              meterType = value;
              return null;
            },
          ),

        ],
      ),
    );
  }
}