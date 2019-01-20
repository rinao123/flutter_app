import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Vip extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _VipState();
  }
}

class _VipState extends State<Vip> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'BecomeDistributor',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('VIP'),
          backgroundColor: Color.fromRGBO(255, 126, 26, 1),
        ),
        body: new Center(
          child: new Text('BecomeDistributor'),
        ),
      ),
    );
  }
}
