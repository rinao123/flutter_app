import "package:flutter/material.dart";
import "package:flutter_app/pages/splash.dart";
import "package:flutter_app/configs/config.dart";

void main() => runApp(App());

class App extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: Config.APP_NAME,
            home: new Splash()
        );
    }
}
