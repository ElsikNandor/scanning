import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'screenargument.dart';

final _formKey = GlobalKey<FormState>();
String scanningString = "Username";

class ConstNum extends StatefulWidget {
  const ConstNum({Key? key}) : super(key: key);

  @override
  State<ConstNum> createState() => _ConstNumState();
}

class _ConstNumState extends State<ConstNum> {
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
    scanningString = args.message;
    final formkey = GlobalKey<FormState>();
    //final ButtonStyle style = TextButton.styleFrom(textStyle:  Theme.of(context).colorScheme.onPrimary,);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gyszbev'),
        actions: <Widget>[
        TextButton.icon(
        icon: const Icon(Icons.cabin, color: Colors.white,) ,
        onPressed: () { Navigator.pushReplacementNamed(context, '/'); },
        label: const Text(''),
      )]
      ),
      body: Column(children: [
          Text(
          "Select: " + scanningString ),

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