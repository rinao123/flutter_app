import "package:dio/dio.dart";
import 'package:flutter/widgets.dart';
import "package:flutter_app/apis/auth_api.dart";
import 'package:flutter_app/common/http_helper.dart';
import 'package:flutter_app/models/user_info_model.dart';
import 'package:flutter_app/provider/user_info.dart';
import 'package:provider/provider.dart';

class AuthController {
	static Future<bool> login(String code, {BuildContext context}) async {
		Response response = await AuthApi.login(code);
		bool isSuccess = false;
		if (response == null) {
			return isSuccess;
		}
		if (response.data["ret"] != 0) {
			print("login fail:${response.data["msg"]}");
			return isSuccess;
		}
		HttpHelper.setSkey(response.data["data"]["skey"]);
		if (context != null) {
			UserInfoModel userInfoModel = UserInfoModel.fromJson(response.data["data"]["userinfo"]);
			Provider.of<UserInfo>(context).setUserInfo(userInfoModel);
		}
		isSuccess = true;
		return isSuccess;
	}
}