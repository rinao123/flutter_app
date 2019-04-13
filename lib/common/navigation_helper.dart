import "package:flutter/widgets.dart";
import "package:flutter_app/pages/goods_detail.dart";
import "package:flutter_app/pages/home.dart";
import "package:flutter_app/pages/index.dart";
import "package:flutter_app/pages/member.dart";
import "package:flutter_app/pages/cart.dart";
import "package:flutter_app/pages/my_info.dart";
import "package:flutter_app/pages/special.dart";

class NavigationHelper {
    static getPage(String path, {Map<String, dynamic> params}) {
        switch (path) {
            case "/pages/home/home":
                return Home();
            case "/pages/index/index":
                return Index();
            case "/pages/member/member":
                return Member();
            case "/pages/cart/cart":
                return Cart();
            case "/pages/myinfo/myinfo":
                return MyInfo();
            case "/pages/special/special":
                if (!params.containsKey("code")) {
                    print("getPage Special code is null");
                    return null;
                }
                return Special(params["code"]);
            case "/pages/goods_detail/goods_detail":
                if (!params.containsKey("id")) {
                    print("getPage GoodsDetail id is null");
                    return null;
                }
                int id = int.parse(params["id"]);
                return GoodsDetail(id);
            default:
                print("NavigationHelper invalid path");
        }
    }

    static void navigateTo(BuildContext context, String url) {
        String path = getPath(url);
        Map<String, String> params = getParams(url);
        var page = getPage(path, params: params);
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
                return SlideTransition(
                    position: Tween<Offset>(
                        begin: Offset(1.0, 0.0),
                        end: Offset(0.0, 0.0),
                    ).animate(animation),
                    child: child,
                );
            })
        );
    }

    static void redirect(BuildContext context, String url) {
        String path = getPath(url);
        Map<String, String> params = getParams(url);
        var page = getPage(path, params: params);
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

    static String getPath(String url) {
        List<String> strs = url.split("?");
        return strs[0];
    }

    static Map<String, String> getParams(String url) {
        List<String> strs = url.split("?");
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
        return params;
    }
}