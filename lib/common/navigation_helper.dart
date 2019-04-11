import "package:flutter/widgets.dart";
import "package:flutter_app/pages/home.dart";
import "package:flutter_app/pages/index.dart";
import "package:flutter_app/pages/member.dart";
import "package:flutter_app/pages/cart.dart";
import "package:flutter_app/pages/my_info.dart";

class NavigationHelper {
    static getPage(path) {
        switch(path){
        case "pages/home/home":
            return new Home();
        case "pages/index/index":
            return new Index();
            case "pages/member/member":
                return new Member();
            case "pages/cart/cart":
                return new Cart();
            case "pages/myinfo/myinfo":
                return new MyInfo();
            default:
                print("NavigationHelper invalid path");
        }
    }

    static void navigateTo(BuildContext context, String path) {
        var page = getPage(path);
        Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) {
                return page;
            }
        ));
    }

    static void redirect(BuildContext context, String path) {
        var page = getPage(path);
        Navigator.pushReplacement(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) {
                return page;
            }
        ));
    }
}