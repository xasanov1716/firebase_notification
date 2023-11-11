import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:texno_bozor/data/models/universal_data.dart';

import '../../../utils/constants.dart';

class ApiService {
  final _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "key=$apiKey"
      },
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeout),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeout),
    ),
  );

  ApiService() {
    _init();
  }

  _init() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          debugPrint("ERRORGA KIRDI:${error.message} and ${error.response}");
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          debugPrint("SO'ROV  YUBORILDI :${requestOptions.path}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint("JAVOB  KELDI :${response.requestOptions.path}");
          return handler.next(response);
        },
      ),
    );
  }

  Future<UniversalReponse> notification(
      {required String title,
        required String description,
        required String image}) async {
    Response response;
    try {
      response = await _dio.post("/fcm/send", data: {
        "to": "/topics/news",
        "notification": {"title": "TWITTER", "body": "YANGILIKLAR DUNYOSI"},
        "data": {"title": title, "body": description, "image": image}
      });

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalReponse(data: response.data);
      }
      return UniversalReponse(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalReponse(error: e.response!.data["message"]);
      } else {
        return UniversalReponse(error: e.message!);
      }
    } catch (error) {
      return UniversalReponse(error: error.toString());
    }
  }
}