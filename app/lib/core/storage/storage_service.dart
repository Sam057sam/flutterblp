import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService(this._secureStorage, this._prefs);

  final FlutterSecureStorage _secureStorage;
  final SharedPreferences? _prefs;

  Future<void> write(String key, String value) async {
    if (kIsWeb && _prefs != null) {
      await _prefs!.setString(key, value);
      return;
    }
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    if (kIsWeb && _prefs != null) {
      return _prefs!.getString(key);
    }
    return _secureStorage.read(key: key);
  }

  Future<void> delete(String key) async {
    if (kIsWeb && _prefs != null) {
      await _prefs!.remove(key);
      return;
    }
    await _secureStorage.delete(key: key);
  }
}

final storageProvider = Provider<StorageService>((ref) {
  throw UnimplementedError('StorageService must be overridden in main()');
});
