import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'connection_alert_widget.dart';
import 'connectivity_controller.dart';
import 'myclasses.dart';

//void main() {
  //runApp(const checkNetwork());
//}

class checkNetwork extends StatelessWidget {
  const checkNetwork({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      textDirection: ui.TextDirection.ltr,
      children: [
        MaterialApp(
          title: 'Network conenctivity demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const NetworkCheckPage(title: 'Network conenctivity demo'),
        ),
        const ConnectionAlert(),
      ],
    );
  }
}

class NetworkCheckPage extends StatefulWidget {
  const NetworkCheckPage({super.key, required this.title});

  final String title;

  @override
  State<NetworkCheckPage> createState() => _NetworkCheckPageState();
}

class _NetworkCheckPageState extends State<NetworkCheckPage> {

  ConnectivityController connectivityController = ConnectivityController();

  ValueNotifier<bool> network_state = ValueNotifier(false);

  String nt = "";

  @override
  void initState() {
    connectivityController.init();
    setState(() {
      network_state = connectivityController.isConnected;
      nt = network_state.value.toString();
      print(network_state.value.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [myMenu(username : "", message: "", mlogin: 1,)],
      ),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Network conenctivity demo',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(nt), //== true ? "true" : "false" ),
            ElevatedButton(
              onPressed: () {
                //myReset();
                setState(() {
                  network_state = connectivityController.isConnected;

                  if( network_state.value == false)
                    {
                      nt = "false";
                    }
                  else
                    {
                      nt = "true";
                    }
                });
              },
              child: Text("check"),
            ),

            const ConnectionAlert(),

          ],

        ),

      ),

    );
  }
}
