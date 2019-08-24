import "package:dio/dio.dart";
import "package:flutter_app/apis/goods_api.dart";
import "package:flutter_app/models/goods.dart";

class GoodsController {
	static Future<List<Goods>> getGoodsList(String url, int page, int pageSize) async {
		Response response = await GoodsApi.getGoodsList(url, page, pageSize);
		if (response == null) {
			return null;
		}
		if (response.data["ret"] != 0) {
			print("getGoodsList fail:${response.data["msg"]}");
			return null;
		}
		List<Goods> goodsList = [];
		for (Map<String, dynamic> item in response.data["goods_list"]) {
			Goods goods = Goods.fromJson(item);
			goodsList.add(goods);
		}
		return goodsList;
	}
}