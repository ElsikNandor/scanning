import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanning/data_stores.dart';
import 'package:scanning/main.dart';
import 'package:scanning/order_number.dart';
import 'package:scanning/readingdata.dart';
import 'screenargument.dart';
import 'myclasses.dart';
import 'alert_box.dart';


final _formKey = GlobalKey<FormState>();
String userName = "Username";
String lastSavedNum = "";
String meterNumber = "";
String constNumText = "";
String orderNumber = "";
String owner = "";
bool orderNumBool = false;
List<String> xx = [];
TextEditingController _controller = new TextEditingController();
TextEditingController _lastSaveNum = new TextEditingController();
Map<String, String> rowsData = {"-" : "-"};
int orderNumberAttempt = 0;

int count1 = 0;
int count2 = 0;

class ConstNum extends StatefulWidget {
  const ConstNum({Key? key}) : super(key: key);

  @override
  State<ConstNum> createState() => _ConstNumState();
}

class _ConstNumState extends State<ConstNum> {

  String text = "";


  void initState() {
    super.initState();
    print(orderCountGlobal);

    orderCountGlobal = rcDataGoodCount + rcDataNotGoodCount;
    if( actualOwner == "MG")
      orderCountGlobal = 1;
  setState(() {
    //orderCountGlobal = 0;
      constNumText = "";
      _controller.text = "";
      _lastSaveNum.text = "";
     });


 }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    lastSavedNum = args.lastSavedNum;

    orderNumber = args.message.split(";")[2];
    owner = args.message.split(";")[1];
    userName = args.message.split(";")[0];

    print("OWNER $owner");

    if( rowsData.containsKey("error") )
      {
        rowsData.remove("error");
      }

    void findWhere(List<String> dataList, String sort_prod_num) {
      // Return list of people matching the condition
      //print(ownerMap[owner]);
      final found = dataList.where((element) {
        if( ownerMap[owner] == "4" ) // Jó lenne ha minden állomány ugyanúgy nézne ki 0:gysz, 1:rendelés 3:hgysz
        {
              try{
                return element.split(";")[6] == sort_prod_num;
              }
              catch (e)
            {
              rowsData = {"error" : "owner"};
              return false;
            }

        }
        else
          {
            try{
              //print(element.split(";")[0]);
              return element.split(";")[0] == sort_prod_num;
            }
            catch (e)
            {
              rowsData = {"error" : "owner"};
              return false;
            }

          }
      });


      if (found.isNotEmpty) {
        ownConv.setDatas(found.first, ownerMap[owner].toString());

        rowsData = ownConv.convertData();
        orderNumBool = true;
      }
      else
        {
          orderNumBool = false;
        }
    }

     setState(() {
      meterController.init();
    });

    print(orderCountGlobal);
    print(actualOwner);
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
                ValueListenableBuilder(
                valueListenable: meterController.ismeter,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 110,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onPrimary: Theme
                                .of(context)
                                .colorScheme
                                .onPrimary,
                            primary: Theme
                                .of(context)
                                .colorScheme
                                .primary,
                            backgroundColor: Colors.green,
                            minimumSize: Size(150, 100),
                          )
                              .copyWith(
                              elevation: ButtonStyleButton.allOrNull(0.0)
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {

                              switch(ownerMap[owner])
                                  {
                                case "FG" :
                                  if( meterNumber.length == 18) {
                                    meterNumber = meterNumber.substring(2);
                                    meterNumber = meterNumber.substring(0,8);
                                    print("METER");
                                    print(meterNumber);
                                  }
                                  break;
                                case "ED" :
                                  if( meterNumber.length == 14) {
                                    meterNumber = meterNumber.substring(meterNumber.length-8);
                                    print("METER");
                                    print(meterNumber);
                                  }
                                  else
                                    {
                                      print("METER ELSE");
                                      print(meterNumber);
                                    }
                                  break;
                                case "EON" :
                                  if( meterNumber.length == 15) {
                                    meterNumber = meterNumber.substring(meterNumber.length-8);
                                  }
                                  break;
                                case "MG" :
                                  print("MG meter number");
                                  print(meterNumber);
                                  break;
                              }

                              findWhere(readMeterData, meterNumber);

                              setState(() {
                                meterController.init();
                                print(meterController.ismeter);
                              });

                              showDialog(context: context,
                                  builder: (context) => CheckMessageBox()
                              ).then((value) {
                                    //print(orderNumberAttempt);
                                if (value == "true") {
                                  Navigator.pushReplacementNamed(
                                      context, "/readingData",
                                      arguments: ScreenArguments(userName,
                                          args.message + ";" + meterNumber +
                                              ";-;-;-;-;-;-", ""));
                                }
                              });
                            }
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
                            // onPrimary: Theme.of(context).colorScheme.onPrimary,
                            primary: meterController.ismeter.value == false
                                ? Colors.blue
                                : Colors.grey,
                            minimumSize: Size(150, 100),
                          )
                              .copyWith(
                              elevation: ButtonStyleButton.allOrNull(0.0)
                          ),
                          onPressed: () {
                            if (meterController.ismeter.value) {
                              return null;
                            }
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushReplacementNamed(
                                    context, '/mtype',
                                    arguments: ScreenArguments(userName,
                                        args.message.split(";")[0] + ";" +
                                            args.message.split(";")[1] + ";"
                                            + args.message.split(";")[2] + ";" +
                                            meterNumber, ""));
                              }
                            });
                          },
                          child: Text("Tovább"),
                        ),
                      ),
                    ],
                  );
                }),

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
      SizedBox(
        height: 10,
      ),
      SizedBox(
          child: myListElements(title: "Darabszám:\n", content: readMeterData .length.toString() +" db"),
          //child: Text("Legutóbb bevitt gyári szám:\n" +args.message.split(";")[2]),
          width: (MediaQuery.of(context).size.width-200)/3-200
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(
          child: myListElements(title: "Bevitt darabszám:\n", content: orderCountGlobal.toString() +" db"),
          //child: Text("Legutóbb bevitt gyári szám:\n" +args.message.split(";")[2]),
          width: (MediaQuery.of(context).size.width-200)/3-200
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(
          child: myListElements(title: "Fennmaradó:\n", content: (readMeterData .length-orderCountGlobal).toString() +" db"),
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