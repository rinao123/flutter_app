import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyInfoState();
  }
}

class _MyInfoState extends State<MyInfo> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'MyInfo',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('我的'),
          backgroundColor: Color.fromRGBO(255, 126, 26, 1),
        ),
        body: new Center(
          child: new Text('MyInfo'),
        ),
      ),
    );
  }
}
