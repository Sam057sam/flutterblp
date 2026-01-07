import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/storage/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final storage = StorageService(const FlutterSecureStorage(), prefs);

  runApp(
    ProviderScope(
      overrides: [storageProvider.overrideWithValue(storage)],
      child: const ShamsErpApp(),
    ),
  );
}
