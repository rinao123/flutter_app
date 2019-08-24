import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/navigation_helper.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/controllers/auth_controller.dart";
import "package:fluwx/fluwx.dart" as fluwx;

class Login extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _LoginState();
    }
}

class _LoginState extends State<Login> {

    @override
    void initState() {
        super.initState();
        fluwx.responseFromAuth.listen((data) async {
            bool isSuccess = await AuthController.login(data.code);
            if (isSuccess) {
                this._goToHome();
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: OverflowBox(
                child: Stack(
                    children: <Widget>[
                        Image(
                            image: AssetImage("assets/images/login.jpg"),
                            width: Utils.px2dp(750),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter
                        ),
                        Positioned(
                            top: Utils.px2dp(794),
                            left: Utils.px2dp(168),
                            right: Utils.px2dp(168),
                            child: FlatButton(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                    height: Utils.px2dp(92),
                                ),
                                onPressed: this._login
                            )
                        )
                    ]
                )
            )
        );
    }

    void _login() {
        fluwx.sendAuth(scope: "snsapi_userinfo", state: "wechat_sdk_demo_test");
    }

    void _goToHome() {
        NavigationHelper.redirect(context, "/pages/home/home");
    }
}
