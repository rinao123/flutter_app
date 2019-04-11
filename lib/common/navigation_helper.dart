import "package:flutter/widgets.dart";
import "package:flutter_app/pages/home.dart";
import "package:flutter_app/pages/index.dart";
import "package:flutter_app/pages/member.dart";
import "package:flutter_app/pages/cart.dart";
import "package:flutter_app/pages/my_info.dart";
import "package:flutter_app/pages/special.dart";

class NavigationHelper {
    static getPage(String path, {Map<String, dynamic> params}) {
        switch(path){
        case "/pages/home/home":
            return new Home();
        case "/pages/index/index":
            return new Index();
            case "/pages/member/member":
                return new Member();
            case "/pages/cart/cart":
                return new Cart();
            case "/pages/myinfo/myinfo":
                return new MyInfo();
            case "/pages/special/special":
                if (!params.containsKey("code")) {
                    print("getPage code is null");
                    return null;
                }
                return new Special(params["code"]);
            default:
                print("NavigationHelper invalid path");
        }
    }

    static void navigateTo(BuildContext context, String url) {
        Map<String, dynamic> data = getPathAndParams(url);
        var page = getPage(data["path"], params: data["params"]);
        if (page == null) {
            print("navigateTo page is null");
            return;
        }
        Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                return page;
            },
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                return new SlideTransition(
                    position: new Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: const Offset(0.0, 0.0),
                    ).animate(animation),
                    child: child,
                );
            })
        );
    }

    static void redirect(BuildContext context, String url) {
        Map<String, dynamic> data = getPathAndParams(url);
        var page = getPage(data["path"], params: data["params"]);
        if (page == null) {
            print("navigateTo page is null");
            return;
        }
        Navigator.pushReplacement(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) {
                return page;
            }
        ));
    }

    static Map<String, dynamic> getPathAndParams(String url) {
        List<String> strs = url.split("?");
        String path = strs[0];
        Map<String, String> params = {};
        if (strs.length > 1) {
            String queryString = strs[1];
            List<String> paramStrs = queryString.split("&");
            for (String paramStr in paramStrs) {
                List<String> values = paramStr.split("=");
                String key = values[0];
                String value = values[1];
                params[key] = value;
            }
        }
        return {"path": path, "params": params};
    }
}