import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidebarCollapsedNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void set(bool value) => state = value;
}

class RightPanelOpenNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void toggle() => state = !state;
  void set(bool value) => state = value;
}

final sidebarCollapsedProvider =
    NotifierProvider<SidebarCollapsedNotifier, bool>(SidebarCollapsedNotifier.new);

final rightPanelOpenProvider =
    NotifierProvider<RightPanelOpenNotifier, bool>(RightPanelOpenNotifier.new);
