import "package:dio/dio.dart";
import 'package:logging/logging.dart';

import '../apis/goods_api.dart';
import '../models/goods_model.dart';

class GoodsController {
	static final Logger logger = Logger("GoodsController");

	static Future<List<GoodsModel>> getGoodsList(String url, int page, int pageSize) async {
		Response response = await GoodsApi.getGoodsList(url, page, pageSize);
		if (response == null) {
			return null;
		}
		if (response.data["ret"] != 0) {
			logger.warning("getGoodsList fail:${response.data["msg"]}");
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