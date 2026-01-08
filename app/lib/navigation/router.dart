import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_shell/app_shell.dart';
import '../features/customers/customers_page.dart';
import '../features/dashboard/dashboard_page.dart';
import '../features/placeholders/placeholder_page.dart';
import '../features/products/products_page.dart';
import '../features/company/company_page.dart';

final appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: '/analytics',
          builder: (context, state) => const PlaceholderPage(
            title: 'Analytics',
            breadcrumbs: 'Overview / Analytics',
          ),
        ),
        GoRoute(
          path: '/sales/customers',
          builder: (context, state) => const CustomersPage(),
        ),
        GoRoute(
          path: '/sales/quotes',
          builder: (context, state) => const PlaceholderPage(
            title: 'Quotes',
            breadcrumbs: 'Sales / Quotes',
          ),
        ),
        GoRoute(
          path: '/sales/orders',
          builder: (context, state) => const PlaceholderPage(
            title: 'Sales Orders',
            breadcrumbs: 'Sales / Orders',
          ),
        ),
        GoRoute(
          path: '/sales/invoices',
          builder: (context, state) => const PlaceholderPage(
            title: 'Invoices',
            breadcrumbs: 'Sales / Invoices',
          ),
        ),
        GoRoute(
          path: '/sales/payments',
          builder: (context, state) => const PlaceholderPage(
            title: 'Payments',
            breadcrumbs: 'Sales / Payments',
          ),
        ),
        GoRoute(
          path: '/sales/returns',
          builder: (context, state) => const PlaceholderPage(
            title: 'Returns',
            breadcrumbs: 'Sales / Returns',
          ),
        ),
        GoRoute(
          path: '/sales/refunds',
          builder: (context, state) => const PlaceholderPage(
            title: 'Refunds',
            breadcrumbs: 'Sales / Refunds',
          ),
        ),
        GoRoute(
          path: '/purchasing/suppliers',
          builder: (context, state) => const PlaceholderPage(
            title: 'Suppliers',
            breadcrumbs: 'Purchasing / Suppliers',
          ),
        ),
        GoRoute(
          path: '/purchasing/purchase-orders',
          builder: (context, state) => const PlaceholderPage(
            title: 'Purchase Orders',
            breadcrumbs: 'Purchasing / Purchase Orders',
          ),
        ),
        GoRoute(
          path: '/purchasing/grn',
          builder: (context, state) => const PlaceholderPage(
            title: 'GRN',
            breadcrumbs: 'Purchasing / GRN',
          ),
        ),
        GoRoute(
          path: '/purchasing/bills',
          builder: (context, state) => const PlaceholderPage(
            title: 'Bills',
            breadcrumbs: 'Purchasing / Bills',
          ),
        ),
        GoRoute(
          path: '/purchasing/expenses',
          builder: (context, state) => const PlaceholderPage(
            title: 'Expenses',
            breadcrumbs: 'Purchasing / Expenses',
          ),
        ),
        GoRoute(
          path: '/purchasing/expense-categories',
          builder: (context, state) => const PlaceholderPage(
            title: 'Expense Categories',
            breadcrumbs: 'Purchasing / Expense Categories',
          ),
        ),
        GoRoute(
          path: '/inventory/products',
          builder: (context, state) => const ProductsPage(),
        ),
        GoRoute(
          path: '/inventory/import',
          builder: (context, state) => const PlaceholderPage(
            title: 'Product Import',
            breadcrumbs: 'Inventory / Product Import',
          ),
        ),
        GoRoute(
          path: '/inventory/categories',
          builder: (context, state) => const PlaceholderPage(
            title: 'Categories',
            breadcrumbs: 'Inventory / Categories',
          ),
        ),
        GoRoute(
          path: '/inventory/sub-categories',
          builder: (context, state) => const PlaceholderPage(
            title: 'Sub-categories',
            breadcrumbs: 'Inventory / Sub-categories',
          ),
        ),
        GoRoute(
          path: '/inventory/brands',
          builder: (context, state) => const PlaceholderPage(
            title: 'Brands',
            breadcrumbs: 'Inventory / Brands',
          ),
        ),
        GoRoute(
          path: '/inventory/units',
          builder: (context, state) => const PlaceholderPage(
            title: 'Units',
            breadcrumbs: 'Inventory / Units',
          ),
        ),
        GoRoute(
          path: '/inventory/attributes',
          builder: (context, state) => const PlaceholderPage(
            title: 'Attributes',
            breadcrumbs: 'Inventory / Attributes',
          ),
        ),
        GoRoute(
          path: '/inventory/warehouses',
          builder: (context, state) => const PlaceholderPage(
            title: 'Warehouses',
            breadcrumbs: 'Inventory / Warehouses',
          ),
        ),
        GoRoute(
          path: '/inventory/stock/balances',
          builder: (context, state) => const PlaceholderPage(
            title: 'Stock Balances',
            breadcrumbs: 'Inventory / Stock Balances',
          ),
        ),
        GoRoute(
          path: '/inventory/stock/movements',
          builder: (context, state) => const PlaceholderPage(
            title: 'Stock Movements',
            breadcrumbs: 'Inventory / Stock Movements',
          ),
        ),
        GoRoute(
          path: '/inventory/stock/adjustments',
          builder: (context, state) => const PlaceholderPage(
            title: 'Stock Adjustments',
            breadcrumbs: 'Inventory / Stock Adjustments',
          ),
        ),
        GoRoute(
          path: '/inventory/stock/reorder-levels',
          builder: (context, state) => const PlaceholderPage(
            title: 'Reorder Levels',
            breadcrumbs: 'Inventory / Reorder Levels',
          ),
        ),
        GoRoute(
          path: '/finance/ledger',
          builder: (context, state) => const PlaceholderPage(
            title: 'Ledger',
            breadcrumbs: 'Finance / Ledger',
          ),
        ),
        GoRoute(
          path: '/finance/chart-of-accounts',
          builder: (context, state) => const PlaceholderPage(
            title: 'Chart of Accounts',
            breadcrumbs: 'Finance / Chart of Accounts',
          ),
        ),
        GoRoute(
          path: '/finance/taxes',
          builder: (context, state) => const PlaceholderPage(
            title: 'Taxes',
            breadcrumbs: 'Finance / Taxes',
          ),
        ),
        GoRoute(
          path: '/operations/shipments',
          builder: (context, state) => const PlaceholderPage(
            title: 'Shipments',
            breadcrumbs: 'Operations / Shipments',
          ),
        ),
        GoRoute(
          path: '/operations/files',
          builder: (context, state) => const PlaceholderPage(
            title: 'File Manager',
            breadcrumbs: 'Operations / Files',
          ),
        ),
        GoRoute(
          path: '/operations/backups',
          builder: (context, state) => const PlaceholderPage(
            title: 'Backups',
            breadcrumbs: 'Operations / Backups',
          ),
        ),
        GoRoute(
          path: '/operations/company',
          builder: (context, state) => const CompanyPage(),
        ),
        GoRoute(
          path: '/operations/exports',
          builder: (context, state) => const PlaceholderPage(
            title: 'Exports',
            breadcrumbs: 'Operations / Exports',
          ),
        ),
        GoRoute(
          path: '/admin/users',
          builder: (context, state) => const PlaceholderPage(
            title: 'Users',
            breadcrumbs: 'Administration / Users',
          ),
        ),
        GoRoute(
          path: '/admin/roles',
          builder: (context, state) => const PlaceholderPage(
            title: 'Roles & Permissions',
            breadcrumbs: 'Administration / Roles',
          ),
        ),
        GoRoute(
          path: '/admin/settings',
          builder: (context, state) => const PlaceholderPage(
            title: 'Admin Settings',
            breadcrumbs: 'Administration / Settings',
          ),
        ),
        GoRoute(
          path: '/more',
          builder: (context, state) => const PlaceholderPage(
            title: 'More',
            breadcrumbs: 'Navigation / More',
          ),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('Route not found: ${state.uri}')),
  ),
);
