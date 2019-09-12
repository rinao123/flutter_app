import "package:dio/dio.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/configs/config.dart";

class HttpHelper {
    static Dio _instance;
    static String _skey;

    static Dio _getInstance() {
        if (_instance == null) {
            _instance = Dio();
//            _instance.interceptors.add(LogInterceptor(request:true, requestHeader: true, requestBody: true, responseHeader: true, responseBody: true, error: true));
        }
        return _instance;
    }

    static void setSkey(skey) {
        _skey = skey;
    }

    static Future request(String path, {FormData data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, ProgressCallback onSendProgress, ProgressCallback onReceiveProgress}) async {
        if (options == null) {
            options = Options();
        }
        options.headers["appkey"] = Config.APP_KEY;
        if (_skey == null || _skey.isEmpty) {
            String skey = await Utils.getSkey();
            setSkey(skey);
        }
        options.headers["X-WX-Skey"] = _skey;
        Utils.getDeviceInfo();
        Dio dio = _getInstance();
        try {
            Response response = await dio.request(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
            return response;
        } on DioError catch (error) {
            if (error.response != null) {
                print(error.response.statusCode);
                print(error.response.data);
                print(error.response.headers);
                print(error.response.request);
            } else{
                print(error.request);
                print(error.message);
            }
        }
    }
}