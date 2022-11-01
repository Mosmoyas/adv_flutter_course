import 'dart:io';

import 'package:adv_flutter_course/app/app_preferences%20.dart';
import 'package:adv_flutter_course/app/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application";
const String CONTENT_TYPE = "content_type";
const String ACCEPt = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String language = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPt: APPLICATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LANGUAGE: language
    };
    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: headers,
        receiveTimeout: Constants.appTimeOut,
        sendTimeout: Constants.appTimeOut);

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
          requestBody: true, requestHeader: true, responseHeader: true));
    }
    return dio;
  }
}
