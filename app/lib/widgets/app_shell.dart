import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/navigation/app_routes.dart';
import 'right_panel.dart';
import 'sidebar.dart';
import 'topbar.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool _collapsed = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1000;

    if (!isDesktop) {
      return _MobileShell(child: widget.child);
    }

    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            collapsed: _collapsed,
            onToggle: () => setState(() => _collapsed = !_collapsed),
          ),
          Expanded(
            child: Column(
              children: [
                TopBar(
                  onToggleSidebar: () => setState(() => _collapsed = !_collapsed),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
          const RightPanel(),
        ],
      ),
    );
  }
}

class _MobileShell extends StatelessWidget {
  const _MobileShell({required this.child});

  final Widget child;

  int _navIndexForLocation(String location) {
    if (location.startsWith('/sales')) return 1;
    if (location.startsWith('/inventory')) return 2;
    if (location.startsWith('/settings') || location.startsWith('/admin')) {
      return 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final location = router.routerDelegate.currentConfiguration.uri.toString();
    final index = _navIndexForLocation(location);

    return Scaffold(
      appBar: AppBar(title: const Text('Shams ERP')),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              const DrawerHeader(
                child: Text(
                  'Modules',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              for (final route in appRoutes)
                ListTile(
                  leading: Icon(route.icon),
                  title: Text(route.title),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.go(route.path);
                  },
                ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          switch (value) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/sales/customers');
              break;
            case 2:
              context.go('/inventory/products');
              break;
            case 3:
              context.go('/settings');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.point_of_sale), label: 'Sales'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Inventory'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}
