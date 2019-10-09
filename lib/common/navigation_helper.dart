import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/pages/cart.dart';
import 'package:flutter_app/pages/goods_detail.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/index.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:flutter_app/pages/member.dart';
import 'package:flutter_app/pages/my_info.dart';
import 'package:flutter_app/pages/recommend.dart';
import 'package:flutter_app/pages/special.dart';
import 'package:logging/logging.dart';



class NavigationHelper {
    static final Logger logger = Logger("NavigationHelper");

    static getPage(String path, {Map<String, dynamic> params}) {
        switch (path) {
            case "/pages/login/login":
                return Login();
            case "/pages/home/home":
                return Home();
            case "/pages/index/index":
                return Index();
            case "/pages/member/member":
                return Member();
            case "/pages/recommend/recommend":
                return Recommend();
            case "/pages/cart/cart":
                return Cart();
            case "/pages/myinfo/myinfo":
                return MyInfo();
            case "/pages/special/special":
                if (!params.containsKey("code")) {
                    logger.warning("getPage Special code is null");
                    return null;
                }
                return Special(params["code"]);
            case "/pages/goods_detail/goods_detail":
                if (!params.containsKey("id")) {
                    logger.warning("getPage GoodsDetail id is null");
                    return null;
                }
                int id = int.parse(params["id"]);
                return GoodsDetail(id);
            default:
                logger.warning("getPage unknown path");
        }
    }

    static void navigateTo(BuildContext context, String url) {
        String path = getPath(url);
        Map<String, String> params = getParams(url);
        var page = getPage(path, params: params);
        if (page == null) {
            logger.warning("navigateTo page is null");
            return;
        }
        Navigator.push(context, CupertinoPageRoute(
            builder: (BuildContext context){
                return page;
            }
        ));
    }

    static void redirectTo(BuildContext context, String url) {
        String path = getPath(url);
        Map<String, String> params = getParams(url);
        var page = getPage(path, params: params);
        if (page == null) {
            logger.warning("navigateTo page is null");
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