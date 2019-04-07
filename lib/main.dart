import "package:flutter/material.dart";
import "package:flutter_app/pages/splash.dart";

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: new Splash());
  }
}
