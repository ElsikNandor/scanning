import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'screenargument.dart';

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
  //Map MapString;

  void initState() {
    super.initState();
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    argString = args.message;
    final formkey = GlobalKey<FormState>();
    //final ButtonStyle style = TextButton.styleFrom(textStyle:  Theme.of(context).colorScheme.onPrimary,);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Típbev'),
        actions: <Widget>[
        TextButton.icon(
        icon: const Icon(Icons.cabin, color: Colors.white,) ,
        onPressed: () { Navigator.pushReplacementNamed(context, '/'); },
        label: const Text(''),
      )]
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
                "Select: " + argString ),
            constInputForm(),
            SizedBox(
              height: 2,
            ),
            SizedBox(
              width: 110,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    onPrimary: Theme.of(context).colorScheme.onPrimary,
                    primary: Theme.of(context).colorScheme.primary)
                    .copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                onPressed: () {
                  setState(() {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(context, '/mtype',
                          arguments: ScreenArguments("user_meter", argString+";"+meterType) );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tovább')),);
                    }
                  });

                  //calculation();


                },
                child: Text("Tovább"),
              ),
            ),
          ])
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