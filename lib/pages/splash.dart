import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/common/navigation_helper.dart';
import '../common/utils.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SplashState();
  }
}

class _SplashState extends State<Splash> {
  Timer _timer;
  int _count = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
          Padding(padding: EdgeInsets.only(top: Utils.fitDp(250))),
      Center(
          child: Image(
              image: AssetImage('assets/images/logo.jpg'),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              width: Utils.fitDp(186),
              height: Utils.fitDp(186))),
          Padding(padding: EdgeInsets.only(top: Utils.fitDp(20))),
          Text("优米共享", textAlign: TextAlign.center, style: TextStyle(fontSize: Utils.fitDp(40), color: Color.fromRGBO(51, 51, 51, 1), fontWeight: FontWeight.bold))
    ]));
  }

  @override
  void initState() {
    super.initState();
    this._countDown();
  }

  @override
  void dispose() {
    this._timer?.cancel();
    super.dispose();
  }

  void _countDown() {
    this._timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      this.setState(() {
        print(this._count);
        this._count--;
        if (this._count == 0) {
          this._goToLogin();
          this._timer.cancel();
        }
      });
    });
  }

  void _goToLogin() {
    NavigationHelper.redirect(context, "/pages/home/home");
  }
}
