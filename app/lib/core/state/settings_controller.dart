import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/storage_service.dart';

const _baseUrlKey = 'settings.base_url';
const _themeModeKey = 'settings.theme_mode';

class SettingsController extends ChangeNotifier {
  SettingsController(this._storage);

  final StorageService _storage;

  String _baseUrl = 'https://api.shamsprojects.com';
  ThemeMode _themeMode = ThemeMode.light;
  bool _isLoading = true;

  String get baseUrl => _baseUrl;
  ThemeMode get themeMode => _themeMode;
  bool get isLoading => _isLoading;

  Future<void> load() async {
    final storedBaseUrl = await _storage.read(_baseUrlKey);
    final storedTheme = await _storage.read(_themeModeKey);

    if (storedBaseUrl != null && storedBaseUrl.isNotEmpty) {
      _baseUrl = storedBaseUrl;
    }

    if (storedTheme != null) {
      _themeMode = storedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateBaseUrl(String value) async {
    _baseUrl = value.trim();
    await _storage.write(_baseUrlKey, _baseUrl);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _storage.write(
      _themeModeKey,
      _themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
    notifyListeners();
  }
}

final settingsProvider = ChangeNotifierProvider<SettingsController>((ref) {
  final storage = ref.watch(storageProvider);
  final controller = SettingsController(storage);
  controller.load();
  return controller;
});
