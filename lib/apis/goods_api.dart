import '../configs/config.dart';
import '../common/http_helper.dart';

class GoodsApi {

    static Future getGoodsList(String url, int page, int pageSize) async {
        return await HttpHelper.request("${Config.GATEWAY}$url", queryParameters: {"page": page, "page_size": pageSize});
    }
}