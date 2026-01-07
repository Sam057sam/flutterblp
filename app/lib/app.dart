import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/state/auth_controller.dart';
import 'core/state/settings_controller.dart';
import 'router.dart';
import 'theme/app_theme.dart';

class ShamsErpApp extends ConsumerWidget {
  const ShamsErpApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final auth = ref.watch(authProvider);
    final router = ref.watch(routerProvider);

    if (settings.isLoading || auth.isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp.router(
      title: 'Shams ERP',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: settings.themeMode,
      routerConfig: router,
    );
  }
}
