
import 'package:flutter/widgets.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/index.dart';

class NavigatorHelper {
  static _getPage(path) {
    switch(path){
      case "/pages/home/home":
        return new Home();
      case "/pages/index/index":
        return new Index();
    }
  }

  static void navigateTo(BuildContext context, String path) {
    var page = _getPage(path);
    Navigator.push(context, PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return page;
        }
    ));
  }

  static void redirect(BuildContext context, String path) {
    var page = _getPage(path);
    Navigator.pushReplacement(context, PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return page;
        }
    ));
  }
}