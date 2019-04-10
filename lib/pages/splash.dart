import "dart:async";
import "dart:ui";

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:flutter/widgets.dart";
import "package:flutter_app/common/navigation_helper.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/configs/config.dart";

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
        SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
        return Scaffold(
            body: Column(
                children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: Utils.px2dp(350))),
                    Center(
                        child: Image(
                            image: AssetImage("assets/images/logo.jpg"),
                            width: Utils.px2dp(186),
                            height: Utils.px2dp(186)
                        )
                    ),
                    Padding(padding: EdgeInsets.only(top: Utils.px2dp(20))),
                    Text(
                        Config.APP_NAME,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Utils.px2dp(40),
                            color: Color.fromRGBO(51, 51, 51, 1),
                            fontWeight: FontWeight.bold
                        )
                    )
                ]
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
        this._timer = Timer.periodic(new Duration(seconds: 1), (timer) {
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
        NavigationHelper.redirect(context, "/pages/login/login");
    }

    void _goToHome() {
        NavigationHelper.redirect(context, "/pages/home/home");
    }
}
