import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/auth_controller.dart';
import '../state/settings_controller.dart';

final dioProvider = Provider<Dio>((ref) {
  final settings = ref.watch(settingsProvider);
  final auth = ref.watch(authProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: settings.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = auth.token;
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ),
  );

  return dio;
});
