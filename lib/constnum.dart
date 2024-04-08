import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanning/data_stores.dart';
import 'package:scanning/main.dart';
import 'package:scanning/readingdata.dart';
import 'screenargument.dart';
import 'myclasses.dart';
import 'package:intl/intl.dart';
import 'alert_box.dart';
//import 'dataread_test.dart';

final _formKey = GlobalKey<FormState>();
String userName = "Username";
String lastSavedNum = "";
String meterNumber = "";
String constNumText = "";
String orderNumber = "";
String owner = "";
bool orderNumBool = false;

TextEditingController _controller = new TextEditingController();
TextEditingController _lastSaveNum = new TextEditingController();
class ConstNum extends StatefulWidget {
  const ConstNum({Key? key}) : super(key: key);

  @override
  State<ConstNum> createState() => _ConstNumState();
}

class _ConstNumState extends State<ConstNum> {
  void initState() {
    super.initState();
    setState(() {
      constNumText = "";
      _controller.text = "";
      _lastSaveNum.text = "";

    });
  }
  String text = "";


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
   // final args = ModalRoute.of(context)!.settings.arguments as SAreadingData;
    userName = args.message;
    lastSavedNum = args.lastSavedNum;

    orderNumber = args.message.split(";")[2];
    owner = args.message.split(";")[1];

    //_lastSaveNum.text = args.lastSavedNum;

    //lastSavedNum = _lastSaveNum.text;
    
    orderDataRead.addDataFile(dataFilePath, orderNumber, owner);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy MMMM dd').format(now);
    print(rCount);

    Map<String, String> rowsData = {"-" : "-"};

   /* Future<void> _loadData() async {
      final loadedData = await orderDataRead.readFile() ; //Kell a beolvasáshoz
      if( rCount < 3 ) { // hogy ne pörögjön a state a beolvasás után, de 2-3 legalább kell, hogy betöltse
        setState(() {
          _data = loadedData;
          print("DATA1");
          print(_data);//_data-ába kerül a fájl tartalma
        });
        rCount++;
      }
    }
    */
    void findPersonUsingWhere(List<String> dataList,
        String sort_prog_num) {
      // Return list of people matching the condition
      final found = dataList.where((element) =>
      element.split(";")[0] == sort_prog_num);

      if (found.isNotEmpty) {
        print('Találat gysz: ${found.first}');
        ownConv.setDatas(found.first, "Főgáz");
        rowsData = ownConv.convertData();
        orderNumBool = true;
      }
      else
        {
          orderNumBool = false;
          print("nincs találat");
        }
    }

    //setState(() {
    //_loadData();

    //findPersonUsingWhere(_data, gysz);
  print("DATA");
  print(data);


    return Scaffold(
      appBar: AppBar(
        title: Text("Gyátrási szám beolvasása | "
            + "Adatrögzítő: " + args.message.split(";")[0]
            + " | Megrendelő: " + args.message.split(";")[1]),
        actions: <Widget>[
          myMenu( username: userName, message: args.message, mlogin: 0),]
      ),
        body:Center(
          child:
    Container(
      width: MediaQuery.of(context).size.width-200,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
      child:

      Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /*SizedBox(
              height: 100,
            ),*/
            Column(
              children: [
                SizedBox(
                  child: myListElements(title: "Legutóbb bevitt gyári szám:\n", content: _lastSaveNum.text.isEmpty == true ? lastSavedNum.split(";")[0] : _lastSaveNum.text.split(";")[0] ),//.split(";")[0]),
                  //child: Text("Legutóbb bevitt gyári szám:\n" +args.message.split(";")[2]),
                  width: (MediaQuery.of(context).size.width-200)/3-100
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    child: myListElements(title: "Legutóbbi minősítés:\n", content: _lastSaveNum.text.isEmpty == true ? lastSavedNum.split(";")[1] : _lastSaveNum.text.split(";")[1]), //lastSavedNum.split(";")[1]),
                    //child: Text("Legutóbb bevitt gyári szám:\n" +args.message.split(";")[2]),
                    width: (MediaQuery.of(context).size.width-200)/3-100
                )

              ],
            ),
             SizedBox(
               width: 10,
             ),
             Column(
               children: [
                 SizedBox(
                   child: constInputForm(),
                   width: (MediaQuery.of(context).size.width-200)/3+200,
                 ),
                 SizedBox(
                   child: winNumPad(constNumText: constNumText, controller: _controller),
                   width: (MediaQuery.of(context).size.width-200)/3+150,
                 ),
                Row(
                  children: [
                    SizedBox(
                      width: 110,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Theme.of(context).colorScheme.onPrimary,
                          primary: Theme.of(context).colorScheme.primary,
                          backgroundColor: Colors.green,
                          minimumSize: Size(150,100),
                        )
                            .copyWith(elevation: ButtonStyleButton.allOrNull(0.0)
                        ),
                        onPressed: ()  {
                          if (_formKey.currentState!.validate()) {

                            findPersonUsingWhere(data, meterNumber);

                            showDialog(context: context,
                                builder: (context) => CheckMessageBox()
                            ).then((value) {
                              print("Dialoge value: " + value);
                              if( value == "true")
                              {

                               //Navigator.pushReplacementNamed(context, "/constnum",
                                 //   arguments: ScreenArguments(argString.split(";")[0],
                                   //     args.message, meterNumber+";"+"jó"
                                                          //)
                                    //);
                               // }
                                    print("Szuper");
                            }
                          });

                          //print("Dialog value: $val");

                              //setState(() {

                          //  if (_formKey.currentState!.validate()) {

                              //Navigator.pushReplacementNamed(context, '/countpos',
                                //  arguments: ScreenArguments(userName, args.message.split(";")[0]+";"+args.message.split(";")[1]+";"
                                  //    +args.message.split(";")[2]+";"+meterNumber, "") );

                                                }
                            //});

                        },
                        child: Text("Keresés"),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    SizedBox(
                      width: 110,
                      height: 50,
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
                              Navigator.pushReplacementNamed(context, '/mtype',
                                  arguments: ScreenArguments(userName, args.message.split(";")[0]+";"+args.message.split(";")[1]+";"
                                      +args.message.split(";")[2]+";"+meterNumber, "") );
                            }
                          });
                        },
                        child: Text("Tovább"),
                      ),
                    ),
                  ],
                )

               ],
             ),

            SizedBox(
              width: 10,
            ),
  Column(
    children: [
       /*SizedBox(
         width: 140,
        //width: (MediaQuery.of(context).size.width-200)/3-50,
         child: Text(formattedDate),
      ),*/
      SizedBox(
          child: myListElements(title: "Megrendelésszám:\n", content: orderNumber),
          //child: Text("Legutóbb bevitt gyári szám:\n" +args.message.split(";")[2]),
          width: (MediaQuery.of(context).size.width-200)/3-200
      ),
    ],
  )

      ])
        )
        )
       // winNumPad(constNumText: constNumText, controller: _controller),

    );
  }
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
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
          TextFormField(
            controller: _controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: 'Gyártási szám',

              border: OutlineInputBorder(),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                //myReset();
                return 'A mező nem lehet üres!';
              }

           /*   try {
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