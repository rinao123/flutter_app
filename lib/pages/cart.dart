import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CartState();
  }
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Cart',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('购物车'),
          backgroundColor: Color.fromRGBO(255, 126, 26, 1),
        ),
        body: new Center(
          child: new Text('Cart'),
        ),
      ),
    );
  }
}
