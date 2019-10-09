import '../configs/config.dart';
import '../common/http_helper.dart';

class GoodsApi {
    static final String getGoodsDetailUrl = "${Config.GATEWAY}/goods/detail";

    static Future getGoodsDetail(int goodsId) async {
        return await HttpHelper.request(getGoodsDetailUrl, queryParameters: {"goods_id": goodsId});
    }

    static Future getGoodsList(String url, int page, int pageSize) async {
        return await HttpHelper.request("${Config.GATEWAY}$url", queryParameters: {"page": page, "page_size": pageSize});
    }
}