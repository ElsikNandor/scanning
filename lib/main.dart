import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';
import 'screenargument.dart';
import 'constnum.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      routes: {
        '/' : (context) => const HomePage(),
        '/constnum' : (context) => const ConstNum(),
        //'/mtype' : (context) => const Mtype(),
        //'/countnum' : (context) => const CountNum()
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _data = "";
  //Map MapString;


  // This function is triggered when the user presses the floating button
  Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('assets/data.txt');
    setState(() {
        _data = loadedData;
    });


  }
  void initState() {
    super.initState();
    _loadData();
    String? savedValue = "";
      setState(() {
        savedValue = _data;
       });
  }


  @override
  Widget build(BuildContext context) {
    int nameCount = _data.split(",").length.toInt();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Program név'),
      ),
      body: LayoutBuilder(builder: (context, constraints)  {
    return SingleChildScrollView(
    child: ConstrainedBox(
    constraints: BoxConstraints(minHeight: constraints.maxHeight),
    child: Column(
    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisAlignment: MainAxisAlignment.start,
    //crossAxisAlignment: CrossAxisAlignment.stretch,
      crossAxisAlignment: CrossAxisAlignment.center,
    children: List.generate(
    nameCount, (index) => ItemWidget(text:  _data.split(",")[index])),
    ),
    ),
    );
    }),
      /*body: Center(
          child: SizedBox(
              width: 300,
              child: Text(_data.split(",").length.toString(),
                  style: const TextStyle(fontSize: 24)))),
              //child: Text(_data ?? 'Nothing to show',
                //  style: const TextStyle(fontSize: 24)))),
      floatingActionButton: FloatingActionButton(
          onPressed: _loadData, child: const Icon(Icons.add)),*/
    );
  }
}
/*class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments( this.title, this.message );
}*/

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Column(
      children : [
        SizedBox(height: 50,),
     Center(
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(150, 100),
      ),
      onPressed: () {
        //myReset();
        Navigator.pushReplacementNamed(context, '/constnum',
            arguments: ScreenArguments("username", text));
      },
      child: Text(text),
      )
    ),
      SizedBox(
          height: 0
      ),
      ]) ;


    /*Card(
      child: SizedBox(
        height: 100,
        child: Center(child: Text(text)),
      ),
    );*/
  }
}

class MyHomePage extends StatefulWidget {
  //const MyHomePage({Key? key, required this.title}) : super(key: key);
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

