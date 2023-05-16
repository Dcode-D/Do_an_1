import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logging_interceptor.dart';

class DioFactory {
  final String _baseUrl;

  DioFactory(this._baseUrl);

  BaseOptions _createBaseOptions() => BaseOptions(
    baseUrl: _baseUrl,
    receiveTimeout: const Duration(seconds:5),
    sendTimeout: const Duration(seconds:5),
    connectTimeout: const Duration(seconds:5),
  );

  Dio create(Logger logger) => Dio(_createBaseOptions())
    ..interceptors.addAll([
      LoggerInterceptor(logger),
    ]);
}