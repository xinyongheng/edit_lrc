import 'package:dio/dio.dart';

import 'utils/text_util.dart';

class Api {
  static late Api _instance;
  static final ERROR_HEAD = "http-error";
  Dio? _dio;
  static Map<String, dynamic> httpHeaders = {
    "user-agent":
        "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36",
    "playss": 5,
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET , POST",
  };

  Api._();

  factory Api() {
    return _instance;
  }

  static void init() {
    _instance = Api._();
  }

  static Future<String> appHttpGet(String path) {
    return Api().parentHttpGet(path);
  }

  Dio dio() {
    if (null == _dio) {
      _dio = Dio();
    }
    return _dio!;
  }

  static Future<String?> requestGet(String path) async {
    Dio dio = new Dio();
    var options = Options(headers: httpHeaders);
    try {
      Response<String?> response = await dio.get(path, options: options);
      Uri uri = response.realUri;
      var path1 = uri.toString();
      // log("$path ---------------  path1=$path1");
      // log("scheme=${uri.scheme} host=${uri.host} path=${uri.path} query=${uri.query}");
      /*if (!path1.contains(AppData.parentUrl)) {
        AppData.parentUrl = uri.scheme + "://" + uri.host;
        log('new path: ${AppData.parentUrl}');
      }*/
      return response.data;
    } catch (e) {
      print(e);
      return "$ERROR_HEAD : ${e.toString()}";
    }
  }

  Future<String> parentHttpGet(String path) async {
    if (!(path.startsWith("https://") || path.startsWith("http://"))) {
      String root = "";
      if (!path.startsWith("/")) {
        root = "/";
      }
      //path = AppData.parentUrl + root + path;
    }
    String? result = await Api.requestGet(path);
    if (TextUtil.isEmpty(result)) {
      return "$ERROR_HEAD : empty data";
    }
    return result!;
  }
}
