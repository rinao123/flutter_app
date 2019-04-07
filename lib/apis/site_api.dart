import "package:flutter_app/configs/config.dart";
import "package:flutter_app/common/http_helper.dart";

class SiteApi {
  static const String getLayoutByCodeUrl = "${Config.gateway}/site/layout";

  static Future getLayoutByCode(String code) async {
    return await HttpHelper.request(getLayoutByCodeUrl, queryParameters: {"code": code});
  }

  static Future getLayouts(String url) async {
    return await HttpHelper.request(url);
  }
}