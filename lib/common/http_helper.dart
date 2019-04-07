import "package:dio/dio.dart";
import "package:flutter_app/configs/config.dart";

class HttpHelper {
  static Dio _instance;
  static Dio _getInstance() {
    if (_instance == null) {
      _instance = new Dio();
    }
    return _instance;
  }

  static Future request(String path, {data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, ProgressCallback onSendProgress, ProgressCallback onReceiveProgress}) async {
    if (options == null) {
      options = new Options();
    }
    options.headers["appkey"] = Config.appKey;
    Dio dio = _getInstance();
    Response response = await dio.request(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
    return response;
  }
}