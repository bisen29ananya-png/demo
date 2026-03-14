import 'package:dio/dio.dart';

import 'package:demo/core/env/app_env.dart';

class DioFactory {
  static Dio create(AppEnv env) {
    final options = BaseOptions(
      baseUrl: env.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/json'},
    );

    final dio = Dio(options);

    if (env.enableNetworkLogs) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: false,
          responseBody: false,
          requestHeader: false,
          responseHeader: false,
        ),
      );
    }

    return dio;
  }
}
