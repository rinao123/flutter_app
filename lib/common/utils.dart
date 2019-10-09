import "dart:io";
import "dart:ui";
import 'package:flutter/material.dart';
import "package:flutter/widgets.dart";
import "package:device_info/device_info.dart";
import "package:shared_preferences/shared_preferences.dart";

class Utils {
    static const DESIGN_WIDTH = 750;
    static double getScreenWidth() => window.physicalSize.width / window.devicePixelRatio;
    static double getScreenHeight() => window.physicalSize.height / window.devicePixelRatio;
    static double getStatusBarHeight(BuildContext context) => MediaQuery.of(context).padding.top;
    static double px2dp(px, {bool isText: false, BuildContext context}) {
        double dp = getScreenWidth() / (DESIGN_WIDTH / window.devicePixelRatio) * px / window.devicePixelRatio;
        if (isText && context != null) {
            dp = dp / MediaQuery.of(context).textScaleFactor;
        }
        return dp;
    }

    static dynamic getDeviceInfo() async {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        if (Platform.isAndroid) {
            return await deviceInfo.androidInfo;
        } else if (Platform.isIOS) {
            return await deviceInfo.iosInfo;
        } else {
            Future.error("unknow device");
        }
    }

    static Color getColorFromString(String str) {
        if (str.isEmpty) {
            return Colors.transparent;
        } else if (str.contains("#")) {
            return getColorFromHex(str);
        } else {
            return getColorFromRGBA(str);
        }
    }

    static Color getColorFromRGBA(String rgba) {
        rgba = rgba.toUpperCase().replaceAll(" ", "");
        int leftIndex = rgba.indexOf("(");
        if (leftIndex <= -1) {
            print("getColorFromRGBA invalid rgba value");
            return null;
        }
        rgba = rgba.substring(leftIndex + 1);
        int rightIndex = rgba.indexOf(")");
        if (rightIndex <= -1) {
            print("getColorFromRGBA invalid rgba value");
            return null;
        }

        rgba = rgba.substring(0, rightIndex);
        List<String> values = rgba.split(",");
        if (values.length < 4) {
            print("getColorFromRGBA invalid rgba value");
            return null;
        }
        int red = int.parse(values[0]);
        int green = int.parse(values[1]);
        int blue = int.parse(values[2]);
        double opacity = double.parse(values[3]);
        return Color.fromRGBO(red, green, blue, opacity);
    }

    static Color getColorFromHex(String hex) {
        String hexColor = hex.toUpperCase().replaceAll("#", "");
        if (hexColor.length != 6) {
            print("getColorFromHex invalid rgb value");
            return null;
        }
        hexColor = "FF" + hexColor;
        return Color(int.parse(hexColor, radix: 16));
    }

    static Future<String> getSkey() async {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        String skey = sharedPreferences.getString("skey") ?? "";
        return skey;
    }

    static String removeNumEndZero(String num) {
        if (!num.contains(".")) {
            return num;
        }
        List<String> strs = num.split(".");
        String result = strs[0];
        String decimal = "";
        bool flag = false;
        for (int i = strs[1].length - 1; i >= 0; i--) {
            if (flag) {
                decimal = strs[1][i] + decimal;
            }
            if (!flag && strs[1][i] != "0") {
                decimal = strs[1][i] + decimal;
                flag = true;
            }
        }
        if (decimal != "") {
            result += "." + decimal;
        }
        return result;
    }

    static String removeLastZero(String num) {
        if (num.contains(".")) {
            String str = "";
            bool isFinished = false;
            for (int i = num.length - 1; i >= 0; i--) {
                String ch = num[i];
                if (isFinished) {
                    str = ch + str;
                    continue;
                }
                if (ch == "0") {
                    continue;
                } else {
                    isFinished = true;
                    if (ch != ".") {
                        str = ch;
                    }
                }
            }
            return str;
        } else {
            return num;
        }
    }
}
