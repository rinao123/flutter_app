import "dart:io";
import "dart:ui";
import "package:flutter/widgets.dart";
import "package:device_info/device_info.dart";

class Utils {
    static final double _designWidth = 750;
    static double getScreenWidth() => window.physicalSize.width / window.devicePixelRatio;
    static double getScreenHeight() => window.physicalSize.height / window.devicePixelRatio;
    static double getStatusBarHeight(BuildContext context) => MediaQuery.of(context).padding.top;
    static double px2dp(px) => getScreenWidth() / (_designWidth / window.devicePixelRatio) * px / window.devicePixelRatio;

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

    static Color getColorFromHex(String rgb) {
        String hexColor = rgb.toUpperCase().replaceAll("#", "");
        if (hexColor.length != 6) {
            print("getColorFromHex invalid rgb value");
            return null;
        }
        hexColor = "FF" + hexColor;
        return Color(int.parse(hexColor, radix: 16));
    }
}
