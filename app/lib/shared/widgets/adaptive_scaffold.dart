import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app_shell/app_shell_state.dart';
import '../../navigation/app_routes.dart';
import 'glass_background.dart';
import 'glass_sidebar.dart';
import 'glass_top_bar.dart';
import 'right_panel.dart';

class AdaptiveScaffold extends ConsumerWidget {
  const AdaptiveScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  List<String> _breadcrumbsForLocation(String location) {
    final match = appRoutes.firstWhere(
      (route) => location == route.path || location.startsWith(route.path),
      orElse: () => appRoutes.first,
    );
    return [match.group, match.title];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 720;
    final isTablet = width >= 720 && width < 1100;
    final location = GoRouter.of(context).routerDelegate.currentConfiguration.uri
        .toString();

    final breadcrumbs = _breadcrumbsForLocation(location);
    final rightPanelOpen = ref.watch(rightPanelOpenProvider);

    return GlassBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: isMobile ? const _AppDrawer() : null,
        bottomNavigationBar: isMobile ? _BottomNav(location: location) : null,
        body: SafeArea(
          child: Row(
            children: [
              if (!isMobile)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: isTablet
                      ? const _RailNav()
                      : Consumer(
                          builder: (context, ref, _) {
                            final collapsed = ref.watch(sidebarCollapsedProvider);
                            return GlassSidebar(
                              collapsed: collapsed,
                              onToggle: () => ref
                                  .read(sidebarCollapsedProvider.notifier)
                                  .state =
                                      !ref.read(sidebarCollapsedProvider),
                            );
                          },
                        ),
                ),
              Expanded(
                child: Column(
                  children: [
                    if (!isMobile)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                        child: GlassTopBar(
                          breadcrumbs: breadcrumbs,
                          onToggleSidebar: () => ref
                              .read(sidebarCollapsedProvider.notifier)
                              .state = !ref.read(sidebarCollapsedProvider),
                          onToggleRightPanel: () => ref
                              .read(rightPanelOpenProvider.notifier)
                              .state = !rightPanelOpen,
                        ),
                      ),
                    if (isMobile)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                        child: GlassTopBarCompact(
                          breadcrumbs: breadcrumbs,
                          onOpenDrawer: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          16,
                          isMobile ? 16 : 0,
                          rightPanelOpen && !isMobile ? 0 : 16,
                          16,
                        ),
                        child: child,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isMobile && rightPanelOpen)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                  child: SizedBox(width: 280, child: RightPanel()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.location});

  final String location;

  int _indexForLocation() {
    if (location.startsWith('/sales')) return 1;
    if (location.startsWith('/inventory')) return 2;
    if (location.startsWith('/more')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _indexForLocation(),
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            context.go('/dashboard');
            break;
          case 1:
            context.go('/sales/customers');
            break;
          case 2:
            context.go('/inventory/products');
            break;
          case 3:
            Scaffold.of(context).openDrawer();
            break;
        }
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        NavigationDestination(icon: Icon(Icons.point_of_sale), label: 'Sales'),
        NavigationDestination(icon: Icon(Icons.inventory), label: 'Inventory'),
        NavigationDestination(icon: Icon(Icons.more_horiz), label: 'More'),
      ],
    );
  }
}

class _RailNav extends StatelessWidget {
  const _RailNav();

  int _indexForLocation(String location) {
    if (location.startsWith('/sales')) return 1;
    if (location.startsWith('/inventory')) return 2;
    if (location.startsWith('/finance')) return 3;
    if (location.startsWith('/operations')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).routerDelegate.currentConfiguration.uri
        .toString();

    return NavigationRail(
      selectedIndex: _indexForLocation(location),
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            context.go('/dashboard');
            break;
          case 1:
            context.go('/sales/customers');
            break;
          case 2:
            context.go('/inventory/products');
            break;
          case 3:
            context.go('/finance/ledger');
            break;
          case 4:
            context.go('/operations/shipments');
            break;
        }
      },
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard),
          label: Text('Overview'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.point_of_sale),
          label: Text('Sales'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.inventory),
          label: Text('Inventory'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.account_balance),
          label: Text('Finance'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.local_shipping),
          label: Text('Operations'),
        ),
      ],
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Modules',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            for (final group in navigationGroups) ...[
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 6),
                child: Text(
                  group.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              for (final route in appRoutes.where((r) => r.group == group))
                ListTile(
                  leading: Icon(route.icon),
                  title: Text(route.title),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.go(route.path);
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }
}
