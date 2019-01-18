import 'package:flutter/material.dart';
import 'pages/splash.dart';
import 'pages/index.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Splash(),
      routes: <String, WidgetBuilder>{
        '/pages/index/index': (BuildContext context) => new Index()
      },
    );
  }
}
