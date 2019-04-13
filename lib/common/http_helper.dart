import "package:dio/dio.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/configs/config.dart";

class HttpHelper {
    static Dio _instance;
    static Dio _getInstance() {
        if (_instance == null) {
            _instance = Dio();
        }
        return _instance;
    }

    static Future request(String path, {data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, ProgressCallback onSendProgress, ProgressCallback onReceiveProgress}) async {
        print(path);
        if (options == null) {
            options = Options();
        }
        options.headers["appkey"] = Config.APP_KEY;
        options.headers["X-WX-Skey"] = Utils.getSkey();
        Utils.getDeviceInfo();
        Dio dio = _getInstance();
        try {
            Response response = await dio.request(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
            print("response:");
            print(response);
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