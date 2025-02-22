import 'package:flutter/material.dart';
import 'package:scanning/constnum.dart';
import 'screenargument.dart';
import 'package:scanning/main.dart';
import 'myclasses.dart';
import 'dart:async';
import 'data_stores.dart';


final _formKey = GlobalKey<FormState>();
String userName = "Username";
String meterNumber = "";
String constNumText = "";
String actualOwner = "";
String readDataTmp = "1";
//String dataFilePath = "C:/orders/";


TextEditingController _controller = TextEditingController();
class OrderNumber extends StatefulWidget {
  const OrderNumber({super.key, required this.storage});

  final dataRead storage;

  @override
  State<OrderNumber> createState() => _OrderNumberState( storage: dataRead() );
}

class _OrderNumberState extends State<OrderNumber> {
  _OrderNumberState({required this.storage});
 // OrderController orderC = OrderController();
  final dataRead storage;

  late dataChange dataChangeVar;





  Future<List<String>> _loadData() async {
    final loadedData = await storage.readFile() ; //Kell a beolvasáshoz
      readMeterData = loadedData;
      dataChangeVar.dataList.md = loadedData;
      rCount++;
    return readMeterData;
  }


  @override
  void initState() {
    super.initState();




    setState(() {
      orderC.init();
      constNumText = "";
      _controller.text = "";
      orderC.isorder.value = false;
      //orderDir.setDir(dataFilePath);

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
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    //userName = args.message;
    //actualOwner = ownerMap[args.message.split(";")[1]].toString();
    //storage.addDataFile(dataFilePath, args.message.split(";")[2], args.message.split(";")[1]);
    print("reading: " + readMeterDataMap.toString());
    owner = readMeterDataMap["owner"].toString();
    //print("AO " + actualOwner);
  //orderC.init();
    //print("AO2 " + dataStore[1].toString());
    return Scaffold(
        appBar: AppBar(
            title: Text("Megrendelésszám megadása."
                //+ "Adatrögzítő: " + args.message.split(";")[0]
                //+ " | Megrendelő: " + args.message.split(";")[1]
               ),
            actions: <Widget>[
              myMenu( username: readMeterDataMap['user'].toString(), message: readMeterDataMap['owners'].toString(), mlogin: 1,)]
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
                          ValueListenableBuilder(
                              valueListenable: orderC.isorder,
                              builder: (context, value, child) {
                                //if (value.toString() == "true"  ) {
                                  return Row(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                        ),


                                        SizedBox(
                                          width: 110,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Theme.of(context).colorScheme.onPrimary, backgroundColor: Theme.of(context).colorScheme.primary,
                                              minimumSize: Size(150,100),
                                            )
                                                .copyWith(elevation: ButtonStyleButton.allOrNull(0.0)
                                            ),
                                            onPressed: () {
                                              //setState(() {
                                              readMeterData = [];
                                              //orderC.init();
                                              if (_formKey.currentState!.validate()) {
                                                print("OWNER: " + readMeterDataMap["owner"].toString());
                                                if( !orderDir.orderDirExists(meterNumber, ownerMap[ owner ].toString()) ) // rendelésszám meglétének ellenőrzése
                                                //if( !orderDir.orderDirExists(meterNumber, ownerMap[ readDataTmp.toString() ]) ) // rendelésszám meglétének ellenőrzése
                                                    {

                                                  showSnackBarFun(context);
                                                  return;
                                                }
                                                rsDataClassGood.addDataFile(saveDirName, meterNumber, true, ownerMap[owner].toString());
                                                rsDataClassNotGood.addDataFile(saveDirName, meterNumber, false, ownerMap[owner].toString());
                                                widget.storage.addDataFile(dataFilePath, meterNumber, ownerMap[owner].toString());
                                                print(dataFilePath);
                                                widget.storage.readFile().then((value) {
                                                  setState(() {
                                                    //print(value); //kiirja a fájl tartalmát
                                                    readMeterData = value;
                                                    orderC.init();
                                                  });
                                                  //_DataCounts();

                                                  rsDataClassGood.readFile().then((value) {
                                                    setState(() {
                                                      rcDataGoodCount = value.length;
                                                      orderCountGlobal = rcDataGoodCount;
                                                      print(orderCountGlobal);
                                                    });
                                                  });

                                                  rsDataClassNotGood.readFile().then((value) {
                                                    setState(() {

                                                      rcDataNotGoodCount = value.length;
                                                      orderCountGlobal += rcDataNotGoodCount;
                                                      print(orderCountGlobal);
                                                    });
                                                  });




                                                });

                                              }
                                              //  });
                                            },
                                            child: Text("Ellenörzés"),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        SizedBox(
                                          width: 110,
                                          height: 50,
                                          child:
                                          ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(150, 100), backgroundColor: orderC.isorder.value == true ? Colors.green : Colors.grey,
                                              maximumSize: Size(150, 100),
                                            ),
                                            icon: Icon(
                                              Icons.done,
                                              size: 24,
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState!.validate()) {
                                                if (orderC.isorder
                                                    .value) //|| ownerMap[args.message.split(";")[1]].toString() == "MG")
                                                    {
                                                  //readMeterDataMap.addEntries({"order_number" : meterNumber.toString()}.entries);
                                                  mDataClass.setOrderNumber(meterNumber.toString());
                                                  Navigator.pushReplacementNamed(context, '/constnum');
                                                      //arguments: ScreenArguments(userName,
                                                        //  "${args.message.split(";")[0]};${args.message.split(";")[1]};$meterNumber", "-;-"));
                                                }
                                              }
                                            },
                                            label: Text("Tovább"),
                                          ),
                                        ),
                                      ]
                                  );
                              //  } else {
                                //  return const Text("ssss");
                                //}
                              }
                          ),

                          winNumPad(constNumText: constNumText, controller: _controller),



                        ])
                )
            )
        )
    );
  }
}

showSnackBarFun(context) {
  SnackBar snackBar = SnackBar(
      duration: const Duration(seconds: 1),
    content: const Text('A megadott megrendelésszám nem található vagy rossz szolgáltató lett megadva!',
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