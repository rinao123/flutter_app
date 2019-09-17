import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../apis/site_api.dart';
import '../models/advice_model.dart';
import '../models/layout/layout_model.dart';

class SiteController {
	static final Logger logger = Logger("SiteController");

	static Future<LayoutModel> getLayoutByCode(String code) async {
		Response response = await SiteApi.getLayoutByCode(code);
		if (response == null) {
			return null;
		}
		if (response.data["ret"] != 0) {
			logger.warning("getLayoutByCode fail:${response.data["msg"]}");
			return null;
		}
		String url = response.data["layout_url"];
		if (url.isEmpty) {
			logger.warning("getLayoutByCode url is empty");
			return null;
		}
		return getLayouts(response.data["layout_url"]);
	}

	static Future<LayoutModel> getLayouts(String url) async {
		Response response = await SiteApi.getLayouts(url);
		if (response == null) {
			return null;
		}
		return LayoutModel.fromJson(response.data);
	}

	static Future<List<AdviceModel>> getAdList(String code) async {
		Response response = await SiteApi.getAdList(code);
		if (response == null) {
			return null;
		}
		if (response.data["ret"] != 0) {
			logger.warning("getAdList fail:${response.data["msg"]}");
			return null;
		}
		List<AdviceModel> advices = [];
		for (Map<String, dynamic> ad in response.data["ads"]) {
			AdviceModel adviceModel = AdviceModel.fromJson(ad);
			advices.add(adviceModel);
		}
		return advices;
	}


}