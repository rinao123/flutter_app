import "package:dio/dio.dart";
import "package:flutter_app/configs/config.dart";
import "package:flutter_app/common/http_helper.dart";

class AuthApi {
    static final String checkUrl = "${Config.GATEWAY}/auth/check";
    static final String  loginUrl = "${Config.GATEWAY}/auth/login";

    static Future check(String code) async {
        FormData data = FormData.from({"via": "", "system_info": "{}"});
        return await HttpHelper.request(checkUrl, data: data);
    }
}