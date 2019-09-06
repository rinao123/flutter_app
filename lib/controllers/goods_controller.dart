import "package:dio/dio.dart";
import "package:flutter_app/apis/goods_api.dart";
import "package:flutter_app/models/goods_model.dart";

class GoodsController {
	static Future<List<GoodsModel>> getGoodsList(String url, int page, int pageSize) async {
		Response response = await GoodsApi.getGoodsList(url, page, pageSize);
		if (response == null) {
			return null;
		}
		if (response.data["ret"] != 0) {
			print("getGoodsList fail:${response.data["msg"]}");
			return null;
		}
		List<GoodsModel> goodsList = [];
		for (Map<String, dynamic> item in response.data["goods_list"]) {
			GoodsModel goodsModel = GoodsModel.fromJson(item);
			goodsList.add(goodsModel);
		}
		return goodsList;
	}
}