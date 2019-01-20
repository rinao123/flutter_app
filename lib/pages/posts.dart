import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Posts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PostsState();
  }
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Posts',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('购物圈'),
          backgroundColor: Color.fromRGBO(255, 126, 26, 1),
        ),
        body: new Center(
          child: new Text('Posts'),
        ),
      ),
    );
  }
}
