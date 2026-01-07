import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/navigation/app_routes.dart';
import 'core/state/auth_controller.dart';
import 'features/auth/login_page.dart';
import 'features/customers/customers_page.dart';
import 'features/dashboard/dashboard_page.dart';
import 'features/placeholders/placeholder_page.dart';
import 'features/products/products_page.dart';
import 'features/settings/settings_page.dart';
import 'widgets/app_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: auth,
    redirect: (context, state) {
      if (auth.isLoading) return null;
      final loggingIn = state.matchedLocation == '/login';
      if (!auth.isAuthenticated) {
        return loggingIn ? null : '/login';
      }
      if (loggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/', builder: (context, state) => const DashboardPage()),
          GoRoute(
            path: '/analytics',
            builder: (context, state) => const PlaceholderPage(title: 'Analytics'),
          ),
          GoRoute(
            path: '/sales/customers',
            builder: (context, state) => const CustomersPage(),
          ),
          GoRoute(
            path: '/sales/quotes',
            builder: (context, state) => const PlaceholderPage(title: 'Quotes'),
          ),
          GoRoute(
            path: '/sales/orders',
            builder: (context, state) => const PlaceholderPage(title: 'Sales Orders'),
          ),
          GoRoute(
            path: '/sales/invoices',
            builder: (context, state) => const PlaceholderPage(title: 'Invoices'),
          ),
          GoRoute(
            path: '/sales/payments',
            builder: (context, state) => const PlaceholderPage(title: 'Payments'),
          ),
          GoRoute(
            path: '/sales/returns',
            builder: (context, state) =>
                const PlaceholderPage(title: 'Returns & Refunds'),
          ),
          GoRoute(
            path: '/purchasing/suppliers',
            builder: (context, state) => const PlaceholderPage(title: 'Suppliers'),
          ),
          GoRoute(
            path: '/purchasing/orders',
            builder: (context, state) =>
                const PlaceholderPage(title: 'Purchase Orders'),
          ),
          GoRoute(
            path: '/purchasing/grn',
            builder: (context, state) => const PlaceholderPage(title: 'GRN'),
          ),
          GoRoute(
            path: '/purchasing/bills',
            builder: (context, state) => const PlaceholderPage(title: 'Bills'),
          ),
          GoRoute(
            path: '/purchasing/expenses',
            builder: (context, state) => const PlaceholderPage(title: 'Expenses'),
          ),
          GoRoute(
            path: '/purchasing/expense-categories',
            builder: (context, state) =>
                const PlaceholderPage(title: 'Expense Categories'),
          ),
          GoRoute(
            path: '/inventory/products',
            builder: (context, state) => const ProductsPage(),
          ),
          GoRoute(
            path: '/inventory/categories',
            builder: (context, state) => const PlaceholderPage(title: 'Categories'),
          ),
          GoRoute(
            path: '/inventory/sub-categories',
            builder: (context, state) =>
                const PlaceholderPage(title: 'Sub-categories'),
          ),
          GoRoute(
            path: '/inventory/brands',
            builder: (context, state) => const PlaceholderPage(title: 'Brands'),
          ),
          GoRoute(
            path: '/inventory/units',
            builder: (context, state) => const PlaceholderPage(title: 'Units'),
          ),
          GoRoute(
            path: '/inventory/attributes',
            builder: (context, state) => const PlaceholderPage(title: 'Attributes'),
          ),
          GoRoute(
            path: '/inventory/import',
            builder: (context, state) =>
                const PlaceholderPage(title: 'Product Import'),
          ),
          GoRoute(
            path: '/inventory/warehouses',
            builder: (context, state) => const PlaceholderPage(title: 'Warehouses'),
          ),
          GoRoute(
            path: '/inventory/balances',
            builder: (context, state) => const PlaceholderPage(title: 'Stock Balances'),
          ),
          GoRoute(
            path: '/inventory/movements',
            builder: (context, state) => const PlaceholderPage(title: 'Stock Movements'),
          ),
          GoRoute(
            path: '/inventory/adjustments',
            builder: (context, state) => const PlaceholderPage(title: 'Adjustments'),
          ),
          GoRoute(
            path: '/inventory/reorder',
            builder: (context, state) => const PlaceholderPage(title: 'Reorder Levels'),
          ),
          GoRoute(
            path: '/finance/ledger',
            builder: (context, state) => const PlaceholderPage(title: 'Ledger'),
          ),
          GoRoute(
            path: '/finance/accounts',
            builder: (context, state) =>
                const PlaceholderPage(title: 'Chart of Accounts'),
          ),
          GoRoute(
            path: '/finance/taxes',
            builder: (context, state) => const PlaceholderPage(title: 'Taxes'),
          ),
          GoRoute(
            path: '/operations/shipments',
            builder: (context, state) => const PlaceholderPage(title: 'Shipments'),
          ),
          GoRoute(
            path: '/operations/files',
            builder: (context, state) => const PlaceholderPage(title: 'File Manager'),
          ),
          GoRoute(
            path: '/operations/backups',
            builder: (context, state) => const PlaceholderPage(title: 'Backups'),
          ),
          GoRoute(
            path: '/operations/company',
            builder: (context, state) =>
                const PlaceholderPage(title: 'Company Profile'),
          ),
          GoRoute(
            path: '/operations/exports',
            builder: (context, state) => const PlaceholderPage(title: 'Exports'),
          ),
          GoRoute(
            path: '/admin/users',
            builder: (context, state) => const PlaceholderPage(title: 'Users'),
          ),
          GoRoute(
            path: '/admin/roles',
            builder: (context, state) =>
                const PlaceholderPage(title: 'Roles & Permissions'),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.uri}'),
      ),
    ),
  );
});
