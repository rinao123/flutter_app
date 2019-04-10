import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/components/tab_bar.dart";

class Home extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return new _HomeState();
    }
}

class _HomeState extends State<Home> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Home"),
            ),
            body: Column(
                children: <Widget>[
                    Text("Home")
                ]
            ),
            bottomNavigationBar: new BottomTabBar()
        );
    }
}
