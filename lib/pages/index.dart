import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Index extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _IndexState();
  }
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Index',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Index'),
        ),
        body: new Center(
          child: new Text('Index'),
        ),
      ),
    );
  }
}
