import 'package:flutter/material.dart';
import 'connectivity_controller.dart';

import 'network_alert_bar.dart';

class ConnectionAlert extends StatefulWidget {
  const ConnectionAlert({super.key});

  @override
  State<ConnectionAlert> createState() => _ConnectionAlertState();
}

class _ConnectionAlertState extends State<ConnectionAlert> {
  ConnectivityController connectivityController = ConnectivityController();

  @override
  void initState() {
    connectivityController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: connectivityController.isConnected,
        builder: (context, value, child) {

          //return Text(value.toString());
          if (value.toString() == "true"  ) {
            return const SizedBox();
          } else {
            return const NetworkAlertBar();
          }
        });
  }
}
