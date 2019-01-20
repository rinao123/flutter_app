import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../common/NavigatorHelper.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SplashState();
  }
}

class _SplashState extends State<Splash> {
  Timer _timer = null;
  int _count = 3;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Splash',
      home: new Scaffold(
        body: new Center(
          child: new Text('Splash ${_count}'),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _countDown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _countDown() {
    _timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {
        _count--;
        if (_count == 0) {
          _goToIndex();
        }
      });
    });
  }

  void _goToIndex() {
    NavigatorHelper.redirect(context, "/pages/home/home");
  }
}
