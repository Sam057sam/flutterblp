import 'package:flutter_riverpod/flutter_riverpod.dart';

final sidebarCollapsedProvider = StateProvider<bool>((ref) => false);
final rightPanelOpenProvider = StateProvider<bool>((ref) => true);
