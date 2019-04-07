import 'dart:io';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:device_info/device_info.dart';

class ScreenHelper {
  static final double _screenWidth = window.physicalSize.width / window.devicePixelRatio;
  static final double _screenHeight = window.physicalSize.height / window.devicePixelRatio;
  static final double _designWidth = 750;
  static final double _designHeight = 1624;

  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;

  static double fitDp(px) => _screenWidth / (_designWidth / window.devicePixelRatio) * px / window.devicePixelRatio;
  static double getStatusBarHeight(BuildContext context) => MediaQuery.of(context).padding.top;
}

class Utils {
  static double get screenWidth => ScreenHelper.screenWidth;
  static double get screenHeight => ScreenHelper.screenHeight;
  static double fitDp(px) => ScreenHelper.fitDp(px);
  static double getStatusBarHeight(BuildContext context) => ScreenHelper.getStatusBarHeight(context);

  static getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      return await deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      return await deviceInfo.iosInfo;
    } else {
      Future.error("unknow device");
    }
  }
}
