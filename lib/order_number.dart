import 'package:flutter/material.dart';
import 'screenargument.dart';
import 'myclasses.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
final _formKey = GlobalKey<FormState>();
String userName = "Username";
String meterNumber = "";
String constNumText = "";
TextEditingController _controller = new TextEditingController();
class OrderNumber extends StatefulWidget {
  const OrderNumber({Key? key}) : super(key: key);

  @override
  State<OrderNumber> createState() => _OrderNumberState();
}

class _OrderNumberState extends State<OrderNumber> {

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
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    userName = args.message;
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
                                    Navigator.pushReplacementNamed(context, '/constnum',
                                        //arguments: ScreenArguments(userName, userName+";"+meterNumber, "") );
                                    arguments: ScreenArguments(userName, args.message.split(";")[0]+";"+args.message.split(";")[1]+";"+meterNumber, "-;-") );

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