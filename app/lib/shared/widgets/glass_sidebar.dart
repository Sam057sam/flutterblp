import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/app_routes.dart';
import 'glass_surface.dart';

class GlassSidebar extends StatelessWidget {
  const GlassSidebar({
    super.key,
    required this.collapsed,
    required this.onToggle,
  });

  final bool collapsed;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).routerDelegate.currentConfiguration.uri
        .toString();
    final width = collapsed ? 84.0 : 260.0;

    return GlassSurface(
      borderRadius: 24,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment:
                    collapsed ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                children: [
                  if (!collapsed)
                    const Text(
                      'Shams ERP',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  IconButton(
                    icon: Icon(collapsed ? Icons.chevron_right : Icons.chevron_left),
                    onPressed: onToggle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  for (final group in navigationGroups)
                    _NavGroup(
                      group: group,
                      routes: appRoutes
                          .where((route) => route.group == group)
                          .toList(),
                      collapsed: collapsed,
                      location: location,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavGroup extends StatelessWidget {
  const _NavGroup({
    required this.group,
    required this.routes,
    required this.collapsed,
    required this.location,
  });

  final String group;
  final List<AppRoute> routes;
  final bool collapsed;
  final String location;

  bool _isActive(String path) {
    return location == path || location.startsWith(path);
  }

  @override
  Widget build(BuildContext context) {
    if (routes.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment:
            collapsed ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (!collapsed)
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 6),
              child: Text(
                group.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 11,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          for (final route in routes)
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => context.go(route.path),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: _isActive(route.path)
                      ? const Color(0xFF2563EB).withOpacity(0.14)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: collapsed
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Icon(route.icon, color: const Color(0xFF0F172A)),
                    if (!collapsed) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          route.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
