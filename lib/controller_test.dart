
import 'package:flutter/material.dart';
import 'myclasses.dart';

import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';



class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text("TESZT"),
            actions: <Widget>[
              myMenu( username: "test", message: "args.message", mlogin: 0),]
        ),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            ColoredBox(
              color: Colors.red,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: const Text('Next'),
                ),
              ),
            ),
            ColoredBox(
              color: Colors.blue,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: const Text('Previous'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

CounterStorage2 storage = CounterStorage2();

class CounterStorage2 {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter2() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeCounter2(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }
}

class FlutterDemo2 extends StatefulWidget {
  const FlutterDemo2({super.key});

  @override
  State<FlutterDemo2> createState() => _FlutterDemoState2();
}

class _FlutterDemoState2 extends State<FlutterDemo2> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    storage.readCounter2().then((value) {
      setState(() {
        counter = value;
      });
    });
  }

  Future<File> _incrementCounter2() {
    setState(() {
      counter++;
    });

    // Write the variable as a string to the file.
    return storage.writeCounter2(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading and Writing Files'),
      ),
      body: Center(
        child: Text(
          'Button tapped $counter time${counter == 1 ? '' : 's'}.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter2,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}