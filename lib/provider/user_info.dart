import 'package:flutter/material.dart';

import '../models/user_info_model.dart';

class UserInfo extends ChangeNotifier {
	UserInfoModel _userInfoModel;

	UserInfoModel get userInfoModel => this._userInfoModel;

	void setUserInfo(UserInfoModel userInfoModel) {
		this._userInfoModel = userInfoModel;
		notifyListeners();
	}
}