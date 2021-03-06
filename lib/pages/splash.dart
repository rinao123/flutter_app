import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../common/navigation_helper.dart';
import '../common/utils.dart';

class Splash extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _SplashState();
    }
}

class _SplashState extends State<Splash> {
    Timer _timer;
    int _count = 3;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: OverflowBox(
                child: Image.asset(
                    "assets/images/splash.jpg",
                    width: Utils.px2dp(Utils.DESIGN_WIDTH),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter
                )
            )
        );
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
        this._timer = Timer.periodic(Duration(seconds: 1), (timer) {
            this.setState(() {
                this._count--;
                if (this._count == 0) {
                    this._goToHome();
                    this._timer.cancel();
                }
            });
        });
    }

    void _goToLogin() {
        NavigationHelper.redirectTo(context, "/pages/login/login");
    }

    void _goToHome() {
        NavigationHelper.redirectTo(context, "/pages/home/home");
    }
}
