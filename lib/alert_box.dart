import 'package:flutter/material.dart';
import 'package:scanning/constnum.dart';
import 'package:scanning/main.dart';


class CheckMessageBox extends StatelessWidget {
  const CheckMessageBox({super.key});


  @override
  Widget build(BuildContext context) {
   // final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    bool found = orderNumBool;
    print(found);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  alertBoxMessage(context, found),

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
                orderNumberAttempt++;
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

Widget alertBoxMessage(BuildContext context, bool found) {
  if( rowsData["error"] == "owner") {
    //found = false;
    return Container(
      alignment: Alignment.center,
      //color: Colors.red,
      height: 35,
        decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
        ),

        child: RichText(
            text: TextSpan(

                children: <TextSpan>[
                  TextSpan(
                      text : "Megrendelő beállítása nem megfelelő!",
                      style: TextStyle(
                        fontSize: 20,
                          color: Colors.white)

                  ),
                  ]))

    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
      alignment: Alignment.center,
      //color: Colors.red,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),

      child:    Text(
          "Keresett gyártásiszám: " + mDataClass.getConstNum_Cut(),
          style: TextStyle(fontSize: 20,  color: Colors.white)
      ),

  ),
      SizedBox(
        height: 20,
      ),
      Container(
        alignment: Alignment.center,
        //color: Colors.red,
        height: 35,
        decoration: BoxDecoration(
          color: found == true ? Colors.green : Colors.red,
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),

        child:    Text(
            found == true ? 'Megtalálható az adatbázisban.' : 'Nem található.',
            style: TextStyle(fontSize: 20, color: Colors.white)
        ),

      ),


    ],
  );
}