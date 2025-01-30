import 'package:flutter/material.dart';
import 'package:scanning/main.dart';
import 'screenargument.dart';
import 'myclasses.dart';
final _formKey = GlobalKey<FormState>();
String userName = "Username";
String meterNumber = "";
String constNumText = "";
TextEditingController _controller = TextEditingController();
class CountPos extends StatefulWidget {
  const CountPos({super.key});

  @override
  State<CountPos> createState() => _CountPosState();
}

class _CountPosState extends State<CountPos> {

  @override
  void initState() {
    super.initState();
    setState(() {
      constNumText = "";
      _controller.text = "";
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
    print("reading const: " + readMeterDataMap.toString());
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    userName = readMeterDataMap["user"].toString();
    String sendMessage = "";
    String blank = "-";
    return Scaffold(
        appBar: AppBar(
            title: Text("Számláló állás beírása | Adatrögzítő: ${userName} | Megrendelő: ${ readMeterDataMap["owner"]  }"),
            actions: <Widget>[
              myMenu( username: userName, message: userName, mlogin: 0,)]
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
                                foregroundColor: Theme.of(context).colorScheme.onPrimary, backgroundColor: Theme.of(context).colorScheme.primary,
                                minimumSize: Size(150,100),
                              )
                                  .copyWith(elevation: ButtonStyleButton.allOrNull(0.0)
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState!.validate()) {
                                    mDataClass.setCountPos(meterNumber.toString());
                                    //readMeterDataMap.addEntries({"countPos" : meterNumber.toString()}.entries);
                                    if( mDataClass.getOwner().toString() == "Tigáz")
                                      {
                                        Navigator.pushReplacementNamed(context, '/gearpairs');
                                      }
                                    else
                                      {
                                        Navigator.pushReplacementNamed(context, '/readingData');
                                      }

                                          //  arguments: ScreenArguments(userName, "$userName;$meterNumber", "") );
                                    /*Navigator.pushReplacementNamed(context, '/yof',
                                        arguments: ScreenArguments(userName, userName+";"+meterNumber, "") );
*/
                                    /* if( args.message.split(";")[3] == "Metrix")
                                      {
                                        Navigator.pushReplacementNamed(context, '/gearpairs_metrix1',
                                            arguments: ScreenArguments(userName, userName+";"+meterNumber, "") );
                                      }
                                    else
                                      {
                                        Navigator.pushReplacementNamed(context, '/gearpairs',
                                            arguments: ScreenArguments(userName, userName+";"+meterNumber, "") );
                                      }
*/
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
          labelText: 'Számlálóállás',

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