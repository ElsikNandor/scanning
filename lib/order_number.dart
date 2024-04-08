import 'package:flutter/material.dart';
import 'screenargument.dart';
import 'package:flutter/services.dart' show SystemChannels, rootBundle;
import 'package:scanning/main.dart';
import 'myclasses.dart';
import 'dart:io';
import 'dart:async';
import 'data_stores.dart';


final _formKey = GlobalKey<FormState>();
String userName = "Username";
String meterNumber = "";
String constNumText = "";
String dataFilePath = "C:/orders/";


TextEditingController _controller = new TextEditingController();
class OrderNumber extends StatefulWidget {
  const OrderNumber({Key? key}) : super(key: key);

  @override
  State<OrderNumber> createState() => _OrderNumberState();
}

class _OrderNumberState extends State<OrderNumber> {
/*
  String datastorage = "";
  String orderNumber = "";

  Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/order_tmp.txt');
    final dataStorageLocation = await rootBundle.loadString('assets/savedirname.txt');
    final path = await dataStorageLocation.split(";")[0]+":\\"+dataStorageLocation.split(";")[1];
    final file = await File(path+"\\"+loadedData+".csv");
    final loadedData2 = await file.readAsString();

    setState(() {
      orderNumber = loadedData;
      datastorage = loadedData2;

    });
  }*/

  void initState() {
    super.initState();
    setState(() {
      constNumText = "";
      _controller.text = "";
      orderDir.setDir(dataFilePath);
    });
  }

  // onKeyboardTap(String value) {
  //   setState(() {
  //     constNumText = constNumText + value;
  //     _controller.text = constNumText;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    userName = args.message;
    Future<void> _loadData() async {
      final loadedData = await orderDataRead.readFile() ; //Kell a beolvasáshoz
      if( rCount < 3 ) { // hogy ne pörögjön a state a beolvasás után, de 2-3 legalább kell, hogy betöltse
        setState(() {
          data = loadedData;
          print("DATA1");
          print(data);//_data-ába kerül a fájl tartalma
        });
        rCount++;
      }
    }

    return Scaffold(
        appBar: AppBar(
            title: Text("Megrendelésszám megadása."
                //+ "Adatrögzítő: " + args.message.split(";")[0]
                //+ " | Megrendelő: " + args.message.split(";")[1]
               ),
            actions: <Widget>[
              myMenu( username: userName, message: args.message, mlogin: 1,)]
        ),
        body: SingleChildScrollView(
            child:
            Center(
                child:
                SizedBox(
                    width: 500,
                    child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height:50,
                          ),
                          constInputForm(),
                          SizedBox(
                            height:2,
                          ),
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

                                  if (_formKey.currentState!.validate()) {
                                    if( !orderDir.orderDirExists(meterNumber) ) // rendelésszám meglétének ellenőrzése
                                    {
                                     // print("MMM: " + meterNumber);
                                      //print("meter: ");
                                      //print(meterNumber);
                                      showSnackBarFun(context);
                                      return null;
                                    }

                                    orderDataRead.addDataFile(dataFilePath, meterNumber, args.message.split(";")[1]);

                                    _loadData();

                                    Navigator.pushReplacementNamed(context, '/constnum',
                                        //arguments: ScreenArguments(userName, userName+";"+meterNumber, "") );
                                    arguments: ScreenArguments(userName, args.message.split(";")[0]+";"+args.message.split(";")[1]+";"+meterNumber, "-;-") );


                                  }
                                });
                              },
                              child: Text("Tovább"),
                            ),
                          ),
                          winNumPad(constNumText: constNumText, controller: _controller)


                        ])
                )
            )
        )
    );
  }
}

showSnackBarFun(context) {
  SnackBar snackBar = SnackBar(
    content: const Text('A megadott megrendelésszám nem található!',
        style: TextStyle(fontSize: 20)),
    backgroundColor: Colors.red,
    dismissDirection: DismissDirection.up,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        left: 10,
        right: 10),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
Widget LogoutButton(BuildContext context) {
  return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(150, 40),
        ),
        onPressed: () {
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
      child: //Column(
      TextFormField(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Megrendelésszám',

          border: OutlineInputBorder(),
        ),
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            //myReset();
            return 'A mező nem lehet üres!';
          }

       /*  try {
            itmp = double.parse(value);
          } catch(_) {
            //myReset();
            return 'A mező csak számokat tartalmazhat!';
          }*/
          meterNumber = value;
          return null;
        },
      ),

      //   ],
      // ),
    );
  }
}