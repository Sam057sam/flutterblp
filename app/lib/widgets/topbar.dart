import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/navigation/app_routes.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.onToggleSidebar});

  final VoidCallback onToggleSidebar;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderColor = Theme.of(context).dividerColor;
    final location = GoRouter.of(context).routerDelegate.currentConfiguration.uri
        .toString();
    final current = appRoutes.firstWhere(
      (route) => route.path == '/' ? location == '/' : location.startsWith(route.path),
      orElse: () => appRoutes.first,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: onToggleSidebar,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                current.group,
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Text(
                current.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 220,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                filled: true,
                fillColor: colorScheme.surface,
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.flash_on),
            tooltip: 'Quick Actions',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Notifications',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
