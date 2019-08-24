import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:flutter_app/pages/splash.dart";
import "package:flutter_app/configs/config.dart";
import "package:fluwx/fluwx.dart" as fluwx;

void main() {
    runApp(App());
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class App extends StatelessWidget {

    App() {
        fluwx.register(appId:"wx1722b6440ea7da77");
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: Config.APP_NAME,
            home: Splash()
        );
    }
}
