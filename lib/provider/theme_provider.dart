import 'package:flutter/material.dart';

import '../configs/config.dart';
import '../models/theme_model.dart';

class ThemeProvider extends ChangeNotifier {
	ThemeModel _themeModel;

	ThemeModel getThemeModel() {
		if (this._themeModel == null) {
			ThemeModel themeModel = ThemeModel();
			themeModel.mainColor = Config.MAIN_COLOR;
			themeModel.secondaryColor = Config.SECONDARY_COLOR;
			this._themeModel = themeModel;
		}
		return this._themeModel;
	}

	void setUserInfo(ThemeModel themeModel) {
		this._themeModel = themeModel;
		notifyListeners();
	}
}