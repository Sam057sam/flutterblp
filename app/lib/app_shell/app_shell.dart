import 'package:flutter/material.dart';

import '../shared/widgets/adaptive_scaffold.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(child: child);
  }
}
