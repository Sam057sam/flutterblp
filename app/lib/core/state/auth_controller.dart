import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile.dart';
import '../storage/storage_service.dart';

const _tokenKey = 'auth.token';

class AuthController extends ChangeNotifier {
  AuthController(this._storage);

  final StorageService _storage;

  bool _isLoading = true;
  String? _token;
  UserProfile? _user;

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;
  String? get token => _token;
  UserProfile? get user => _user;

  Future<void> load() async {
    _token = await _storage.read(_tokenKey);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> login({
    required String baseUrl,
    required String email,
    required String password,
  }) async {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    final response = await dio.post('/api/v1/auth/login', data: {
      'email': email,
      'password': password,
    });

    final token = response.data['token'] as String?;
    if (token == null || token.isEmpty) {
      throw Exception('Missing token in login response.');
    }

    _token = token;
    await _storage.write(_tokenKey, token);

    final userJson = response.data['user'];
    if (userJson is Map<String, dynamic>) {
      _user = UserProfile.fromJson(userJson);
    }

    notifyListeners();
  }

  Future<void> logout({required Dio dio}) async {
    if (_token != null) {
      try {
        await dio.post('/api/v1/auth/logout');
      } catch (_) {
        if (kDebugMode) {
          debugPrint('Logout request failed, clearing token locally.');
        }
      }
    }

    _token = null;
    _user = null;
    await _storage.delete(_tokenKey);
    notifyListeners();
  }

  void setUser(UserProfile profile) {
    _user = profile;
    notifyListeners();
  }
}

final authProvider = ChangeNotifierProvider<AuthController>((ref) {
  final storage = ref.watch(storageProvider);
  final controller = AuthController(storage);
  controller.load();
  return controller;
});
