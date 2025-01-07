import 'package:flutter/material.dart';
import 'package:scanning/main.dart';
import 'package:scanning/order_number.dart';
import 'package:scanning/readingdata.dart';
import 'screenargument.dart';
import 'myclasses.dart';
import 'alert_box.dart';


final _formKey = GlobalKey<FormState>();
String userName = "Username";
String lastSavedNum = "";
String lastSavedQuality = "";

String meterNumber = "";
String meterNumber_cut = "";
String constNumText = "";
String orderNumber = "";
String owner = "";
bool orderNumBool = false;
List<String> xx = [];
TextEditingController _controller = TextEditingController();
TextEditingController _lastSaveNum = TextEditingController();
Map<String, String> rowsData = {"-" : "-"};
int orderNumberAttempt = 0;

int count1 = 0;
int count2 = 0;

class ConstNum extends StatefulWidget {
  const ConstNum({super.key});

  @override
  State<ConstNum> createState() => _ConstNumState();
}

class _ConstNumState extends State<ConstNum> {

  String text = "";


  @override
  void initState() {
    super.initState();
    print(orderCountGlobal);

    orderCountGlobal = rcDataGoodCount + rcDataNotGoodCount;
    /*if( actualOwner == "MG") {
      orderCountGlobal = 0;
    }*/
  setState(() {
    //orderCountGlobal = 0;
      constNumText = "";
      _controller.text = "";
      _lastSaveNum.text = "";
     });


 }


  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    lastSavedNum = readMeterDataMap['lastSaveNum'].toString(); //args.lastSavedNum;
    lastSavedQuality = readMeterDataMap['lastSaveQuality'].toString(); //args.lastSavedNum;

    orderNumber = readMeterDataMap['order_number'].toString();
    owner = readMeterDataMap['owner'].toString();
    userName = readMeterDataMap['user'].toString();
    print("reading const: " + readMeterDataMap.toString());

    mDataClass.resetDataMapAfterQuality();
    //print("OWNER $owner");
    //print(args);

    if( rowsData.containsKey("error") )
      {
        rowsData.remove("error");
      }

    void findWhere(List<String> dataList, String sortProdNum) {
      // Return list of people matching the condition
      //print(ownerMap[owner]);
      final found = dataList.where((element) {
        if( ownerMap[owner] == "4" ) // Jó lenne ha minden állomány ugyanúgy nézne ki 0:gysz, 1:rendelés 3:hgysz
        {
              try{
                return element.split(";")[6] == sortProdNum;
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
             // print(element.split(";")[0]);
              //print("s" + sortProdNum);
              return element.split(";")[0] == sortProdNum;
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
meterController.init();
//    print(orderCountGlobal);

  //  print(actualOwner);
    return Scaffold(
      appBar: AppBar(
        title: Text("Gyátrási szám beolvasása | Adatrögzítő: ${userName} | Megrendelő: ${owner}"),
        actions: <Widget>[
          myMenu( username: userName, message: readMeterDataMap['user'].toString(), mlogin: 0),]
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
                  width: (MediaQuery.of(context).size.width-200)/3-100,
                  child: myListElements(title: "Legutóbb bevitt gyártási szám:\n", content: lastSavedNum )
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: (MediaQuery.of(context).size.width-200)/3-100,
                    child: myListElements(title: "Legutóbbi minősítés:\n", content:  lastSavedQuality )
                )

              ],
            ),
             SizedBox(
               width: 10,
             ),
             Column(
               children: [
                 SizedBox(
                   width: (MediaQuery.of(context).size.width-200)/3+200,
                   child: constInputForm(),
                 ),
                 SizedBox(
                   width: (MediaQuery.of(context).size.width-200)/3+150,
                   child: winNumPad(constNumText: constNumText, controller: _controller),
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
                            /*foregroundColor: Theme
                                .of(context)
                                .colorScheme
                                .onPrimary, backgroundColor: Theme
                                .of(context)
                                .colorScheme
                                .primary,
                             minimumSize: Size(150, 100),*/
                            backgroundColor: meterController.checkmeter.value == true
                                ? Colors.blue
                                : Colors.grey,
                            minimumSize: Size(150, 100),

                          )
                              .copyWith(
                              elevation: ButtonStyleButton.allOrNull(0.0)
                          ),
                          onPressed: () {

                            if (meterController.checkmeter.value == false) {
                              return;
                            }

                            if (_formKey.currentState!.validate()) {
                              print("hossz : "  + meterNumber.length.toString());
                              switch(ownerMap[mDataClass.getOwner()])
                                  {
                                case "FG" :
                                  switch(meterNumber.length)
                                  {
                                    case 18 :
                                      meterNumber_cut = meterNumber.substring(2);
                                      meterNumber_cut = meterNumber_cut.substring(0,8);
                                      mDataClass.setConstNum_Cut(meterNumber_cut);
                                      //print("METER");
                                      print("FG_18" + meterNumber);
                                      break;
                                    case 14 :
                                      meterNumber_cut = meterNumber.substring(meterNumber.length-8);
                                      print("FG_14" + meterNumber);
                                      mDataClass.setConstNum_Cut(meterNumber_cut);
                                      break;
                                    default :
                                      print("meter rövidFG : " +meterNumber);
                                      meterNumber_cut = meterNumber;
                                      mDataClass.setConstNum_Cut(meterNumber_cut);
                                      break;
                                  }
                                  /*if( meterNumber.length == 18) {
                                    meterNumber_cut = meterNumber.substring(2);
                                    meterNumber_cut = meterNumber.substring(0,8);
                                    //print("METER");
                                    print("FG_mn" + meterNumber);
                                  }
                                  if( meterNumber.length == 14) {
                                    meterNumber_cut = meterNumber.substring(meterNumber.length-8);
                                    //print("METER");
                                    //print(meterNumber);
                                  }
                                  else
                                  {
                                    //print("METER ELSE");
                                    print("meter rövidFG : " +meterNumber);
                                    meterNumber_cut = meterNumber;
                                  }*/
                                  break;
                                case "ED" :
                                  if( meterNumber.length == 14) {
                                    meterNumber_cut = meterNumber.substring(meterNumber.length-8);
                                    //print("METER");
                                    print(meterNumber);
                                  }
                                  else
                                    {
                                      //print("METER ELSE");
                                     print("meter rövid: " +meterNumber);
                                     meterNumber_cut = meterNumber;
                                    }
                                  break;
                                case "EON" :
                                  if( meterNumber.length == 15) {
                                    meterNumber_cut = meterNumber.substring(meterNumber.length-8);
                                  }
                                  else
                                  {
                                    //print("METER ELSE");
                                    print("meter rövid: " +meterNumber);
                                    meterNumber_cut = meterNumber;
                                  }
                                  break;
                                case "OT" :
                                  print("OT meter number");
                                  meterNumber_cut = meterNumber;
                                  break;
                              }

                              findWhere(readMeterData, meterNumber_cut);

                              setState(() {
                                meterController.init();
                                print(meterController.ismeter);
                              });

                              showDialog(context: context,
                                  builder: (context) => CheckMessageBox()
                              ).then((value) {
                                    //print(orderNumberAttempt);
                                if (value == "true") {
                                  //readMeterDataMap.addEntries({"constnum" : meterNumber}.entries);
                                  //readMeterDataMap.addEntries({"constnum_cut" : meterNumber_cut }.entries);
                                  mDataClass.setConstNum(meterNumber.toString());
                                  mDataClass.setConstNum_Cut(meterNumber_cut.toString());
                                  Navigator.pushReplacementNamed(
                                      context, "/countpos");
                                      //arguments: ScreenArguments(userName,
                                        //  "${args.message};$meterNumber_cut;-;-;-;-;-;-", ""));
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
                            backgroundColor: meterController.ismeter.value == false
                                ? Colors.blue
                                : Colors.grey,
                            minimumSize: Size(150, 100),
                          )
                              .copyWith(
                              elevation: ButtonStyleButton.allOrNull(0.0)
                          ),
                          onPressed: () {
                            if (meterController.ismeter.value) {
                              return;
                            }
                            //setState(() {
                              if (_formKey.currentState!.validate()) {
                                mDataClass.setConstNum(meterNumber.toString()+"*");
                                mDataClass.setConstNum_Cut(meterNumber.toString()+"*");
                                Navigator.pushReplacementNamed(
                                    context, '/mtype');
                                    //arguments: ScreenArguments(userName,
                                        //"${args.message.split(";")[0]};${args.message.split(";")[1]};${args.message.split(";")[2]};$meterNumber*", ""));
                              }
                            //});
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
          width: (MediaQuery.of(context).size.width-200)/3-200,
          child: myListElements(title: "Megrendelésszám:\n", content: orderNumber)
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(
          width: (MediaQuery.of(context).size.width-200)/3-200,
          child: myListElements(title: "Darabszám:\n", content: actualOwner == "OT" ? "-" : "${readMeterData .length-1} db")
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(
          width: (MediaQuery.of(context).size.width-200)/3-200,
          child: myListElements(title: "Bevitt darabszám:\n", content: orderCountGlobal == 0 ? (orderCountGlobal).toString() + " db" : (orderCountGlobal).toString() + " db")
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(
          width: (MediaQuery.of(context).size.width-200)/3-200,
          child: myListElements(title: "Fennmaradó:\n", content: ownerMap[mDataClass.getOwner()] == "OT" ? "-" : "${readMeterData .length-orderCountGlobal-1} db")
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
              //meterNumber = value;
              mDataClass.setConstNum(value);
              meterNumber = mDataClass.getConstNum();
              return null;
            },
          ),

      //   ],
      // ),
    );
  }
}