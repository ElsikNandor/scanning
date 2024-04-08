import 'package:flutter/material.dart';
import 'package:scanning/constnum.dart';


class CheckMessageBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   // final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    bool found = orderNumBool;
    return  AlertDialog(
      title: Text('Eredmény'),
      insetPadding: const EdgeInsets.all(10),
      content:  SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            SizedBox(
              width: 400,
              height: 300,
              child:
              Column(
                children: [
                  Text("Gyártási szám: " + meterNumber.toString()),
                  Text(found == true ? 'Megtalálható az adatbázisban.' : 'Nem található.')
                ],
              )

            ),

            //Text('Would you like to approve of this message?'),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text( found == true ? 'Kész' : "Vissza" ),
          onPressed: () {

            if( found == false ) {
/*              Navigator.pushReplacementNamed(context, '/countpos',
                  arguments: ScreenArguments(userName, argString.split(";")[0]+";"+argString.split(";")[1]+";"+argString.split(";")[1]+";"+meterNumber, "") );
  */            Navigator.pop(context, "false");
            }
            else{
              Navigator.pop(context, "true");
            }
          },
        ),
      ],
    );
  }
}