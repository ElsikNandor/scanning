import 'package:flutter/material.dart';
import 'screenargument.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.text,
    required this.path,
    required this.data,
  });

  final String text;
  final String path;
  final String data;
  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(150, 100),
          maximumSize: Size(150, 100),
        ),
        onPressed: () {
          //myReset();
          Navigator.pushReplacementNamed(context, path,
              arguments: ScreenArguments("dataWrite", data));
        },
        child: Text(text),
      );
  }
}