import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../apis/auth_api.dart';
import '../common/http_helper.dart';
import '../models/user_info_model.dart';
import '../provider/user_info.dart';

class AuthController {
	static final Logger logger = Logger("AuthController");

	static Future<bool> login(String code, {BuildContext context}) async {
		Response response = await AuthApi.login(code);
		bool isSuccess = false;
		if (response == null) {
			return isSuccess;
		}
		if (response.data["ret"] != 0) {
			logger.warning("login fail:${response.data["msg"]}");
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