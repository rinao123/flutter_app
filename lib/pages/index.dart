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
          title: new Text('小橙优品'),
          backgroundColor: Color.fromRGBO(255, 126, 26, 1),
        ),
        body: new Center(
          child: new Text('Index'),
        ),
      ),
    );
  }
}
