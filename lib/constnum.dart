import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:scanning/readingdata.dart';
import 'screenargument.dart';
import 'myclasses.dart';
//import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';


final _formKey = GlobalKey<FormState>();
String userName = "Username";
String meterNumber = "";
String constNumText = "";
TextEditingController _controller = new TextEditingController();
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
    });
  }
  String text = "";

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
        title: Text("Gyátrási szám beolvasása | "
            + "Adatrögzítő: " + args.message.split(";")[0]
            + " | Megrendelő: " + args.message.split(";")[1]),
        actions: <Widget>[
          myMenu( username: userName,),]
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
                        Navigator.pushReplacementNamed(context, '/mtype',
                            arguments: ScreenArguments(userName, userName+";"+meterNumber) );
                      }
                    });
                  },
                  child: Text("Tovább"),
                ),
              ),

            winNumPad(constNumText: constNumText, controller: _controller)
            // NumericKeyboard(
            //     onKeyboardTap: onKeyboardTap,
            //     textStyle: const TextStyle(
            //       color: Colors.black,
            //       fontSize: 28,
            //     ),
            //     rightButtonFn: () {
            //       if (constNumText.isEmpty) return;
            //       setState(() {
            //         constNumText = constNumText.substring(0, constNumText.length - 1);
            //         _controller.text = constNumText;
            //       });
            //     },
            //     rightButtonLongPressFn: () {
            //       if (constNumText.isEmpty) return;
            //       setState(() {
            //         constNumText = '';
            //         _controller.text = constNumText;
            //       });
            //     },
            //     rightIcon: const Icon(
            //       Icons.backspace_outlined,
            //       color: Colors.blueGrey,
            //     ),
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween),

      ])
            ),

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
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
          TextFormField(
            controller: _controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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

              try {
                itmp = double.parse(value);
              } catch(_) {
                //myReset();
                return 'A mező csak számokat tartalmazhat!';
              }
              meterNumber = value;
              return null;
            },
          ),

      //   ],
      // ),
    );
  }
}