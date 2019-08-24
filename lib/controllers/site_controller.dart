import "package:dio/dio.dart";
import "package:flutter_app/apis/site_api.dart";
import "package:flutter_app/models/advice.dart";
import "package:flutter_app/models/layout/layout_model.dart";

class SiteController {
	static Future<LayoutModel> getLayoutByCode(String code) async {
		Response response = await SiteApi.getLayoutByCode(code);
		if (response == null) {
			return null;
		}
		if (response.data["ret"] != 0) {
			print("getLayoutByCode fail:${response.data["msg"]}");
			return null;
		}
		String url = response.data["layout_url"];
		if (url.isEmpty) {
			print("getLayoutByCode url is empty");
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

	static Future<List<Advice>> getAdList(String code) async {
		Response response = await SiteApi.getAdList(code);
		if (response == null) {
			return null;
		}
		if (response.data["ret"] != 0) {
			print("getAdList fail:${response.data["msg"]}");
			return null;
		}
		List<Advice> advices = [];
		for (Map<String, dynamic> ad in response.data["ads"]) {
			Advice advice = Advice.fromJson(ad);
			advices.add(advice);
		}
		return advices;
	}


}