import 'dart:io';

import 'package:dio/dio.dart';

import '../configs/config.dart';
import '../common/http_helper.dart';

class AuthApi {
    static final String loginUrl = "${Config.GATEWAY}/auth/app_login";
    static final String checkUrl = "${Config.GATEWAY}/auth/check";

    static Future login(String code) async {
        Map<String, dynamic> headers = {"X-WX-Code": code};
        FormData data = FormData.from({"via": "0", "system_info": "{}", "ext_param": "{}"});
        Options options = Options(method: "POST", contentType: ContentType.parse("application/x-www-form-urlencoded"), headers: headers);
        return await HttpHelper.request(loginUrl, data: data, options: options);
    }

    static Future check(String code) async {
        FormData data = FormData.from({"via": "", "system_info": "{}"});
        return await HttpHelper.request(checkUrl, data: data);
    }
}