import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/navigation/app_routes.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key, required this.collapsed, required this.onToggle});

  final bool collapsed;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final width = collapsed ? 72.0 : 260.0;
    final location = GoRouter.of(context).routerDelegate.currentConfiguration.uri
        .toString();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment:
              collapsed ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!collapsed)
                    const Text(
                      'Shams ERP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  IconButton(
                    icon: Icon(
                      collapsed ? Icons.chevron_right : Icons.chevron_left,
                      color: Colors.white70,
                    ),
                    onPressed: onToggle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  for (final group in _groups)
                    _SidebarGroup(
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

const _groups = [
  'Overview',
  'Sales',
  'Purchasing',
  'Inventory',
  'Finance',
  'Operations',
  'Admin',
  'System',
];

class _SidebarGroup extends StatelessWidget {
  const _SidebarGroup({
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
    if (path == '/' && location == '/') return true;
    return path != '/' && location.startsWith(path);
  }

  @override
  Widget build(BuildContext context) {
    if (routes.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
                  color: Colors.white54,
                  fontSize: 11,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          for (final route in routes)
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => context.go(route.path),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: _isActive(route.path)
                      ? const Color(0xFF14B8A6)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: collapsed
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Icon(route.icon, color: Colors.white),
                    if (!collapsed) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          route.title,
                          style: const TextStyle(color: Colors.white),
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
