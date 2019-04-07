import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TabBarState();
  }
}

class _TabBarState extends State<TabBar> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
        Text("Home")
    ]));
  }
}
