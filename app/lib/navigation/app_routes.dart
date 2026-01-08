import 'package:flutter/material.dart';

class AppRoute {
  const AppRoute({
    required this.title,
    required this.path,
    required this.icon,
    required this.group,
  });

  final String title;
  final String path;
  final IconData icon;
  final String group;
}

const appRoutes = <AppRoute>[
  AppRoute(title: 'Dashboard', path: '/dashboard', icon: Icons.dashboard, group: 'Overview'),
  AppRoute(title: 'Analytics', path: '/analytics', icon: Icons.insights, group: 'Overview'),

  AppRoute(title: 'Customers', path: '/sales/customers', icon: Icons.people, group: 'Sales'),
  AppRoute(title: 'Quotes', path: '/sales/quotes', icon: Icons.description, group: 'Sales'),
  AppRoute(title: 'Sales Orders', path: '/sales/orders', icon: Icons.shopping_cart, group: 'Sales'),
  AppRoute(title: 'Invoices', path: '/sales/invoices', icon: Icons.receipt_long, group: 'Sales'),
  AppRoute(title: 'Payments', path: '/sales/payments', icon: Icons.payments, group: 'Sales'),
  AppRoute(title: 'Returns', path: '/sales/returns', icon: Icons.assignment_return, group: 'Sales'),
  AppRoute(title: 'Refunds', path: '/sales/refunds', icon: Icons.undo, group: 'Sales'),

  AppRoute(title: 'Suppliers', path: '/purchasing/suppliers', icon: Icons.local_shipping, group: 'Purchasing'),
  AppRoute(title: 'Purchase Orders', path: '/purchasing/purchase-orders', icon: Icons.assignment, group: 'Purchasing'),
  AppRoute(title: 'GRN', path: '/purchasing/grn', icon: Icons.receipt, group: 'Purchasing'),
  AppRoute(title: 'Bills', path: '/purchasing/bills', icon: Icons.request_quote, group: 'Purchasing'),
  AppRoute(title: 'Expenses', path: '/purchasing/expenses', icon: Icons.money_off, group: 'Purchasing'),
  AppRoute(title: 'Expense Categories', path: '/purchasing/expense-categories', icon: Icons.category, group: 'Purchasing'),

  AppRoute(title: 'Products', path: '/inventory/products', icon: Icons.inventory, group: 'Inventory'),
  AppRoute(title: 'Import', path: '/inventory/import', icon: Icons.file_upload, group: 'Inventory'),
  AppRoute(title: 'Categories', path: '/inventory/categories', icon: Icons.category, group: 'Inventory'),
  AppRoute(title: 'Sub-categories', path: '/inventory/sub-categories', icon: Icons.category_outlined, group: 'Inventory'),
  AppRoute(title: 'Brands', path: '/inventory/brands', icon: Icons.badge, group: 'Inventory'),
  AppRoute(title: 'Units', path: '/inventory/units', icon: Icons.straighten, group: 'Inventory'),
  AppRoute(title: 'Attributes', path: '/inventory/attributes', icon: Icons.tune, group: 'Inventory'),
  AppRoute(title: 'Warehouses', path: '/inventory/warehouses', icon: Icons.warehouse, group: 'Inventory'),
  AppRoute(title: 'Stock Balances', path: '/inventory/stock/balances', icon: Icons.bar_chart, group: 'Inventory'),
  AppRoute(title: 'Stock Movements', path: '/inventory/stock/movements', icon: Icons.swap_horiz, group: 'Inventory'),
  AppRoute(title: 'Stock Adjustments', path: '/inventory/stock/adjustments', icon: Icons.tune, group: 'Inventory'),
  AppRoute(title: 'Reorder Levels', path: '/inventory/stock/reorder-levels', icon: Icons.warning, group: 'Inventory'),

  AppRoute(title: 'Ledger', path: '/finance/ledger', icon: Icons.account_balance, group: 'Finance'),
  AppRoute(title: 'Chart of Accounts', path: '/finance/chart-of-accounts', icon: Icons.account_tree, group: 'Finance'),
  AppRoute(title: 'Taxes', path: '/finance/taxes', icon: Icons.percent, group: 'Finance'),

  AppRoute(title: 'Shipments', path: '/operations/shipments', icon: Icons.local_shipping, group: 'Operations'),
  AppRoute(title: 'Files', path: '/operations/files', icon: Icons.folder, group: 'Operations'),
  AppRoute(title: 'Backups', path: '/operations/backups', icon: Icons.backup, group: 'Operations'),
  AppRoute(title: 'Company', path: '/operations/company', icon: Icons.business, group: 'Operations'),
  AppRoute(title: 'Exports', path: '/operations/exports', icon: Icons.download, group: 'Operations'),

  AppRoute(title: 'Users', path: '/admin/users', icon: Icons.person, group: 'Administration'),
  AppRoute(title: 'Roles', path: '/admin/roles', icon: Icons.security, group: 'Administration'),
  AppRoute(title: 'Settings', path: '/admin/settings', icon: Icons.settings, group: 'Administration'),
];

const navigationGroups = [
  'Overview',
  'Sales',
  'Purchasing',
  'Inventory',
  'Finance',
  'Operations',
  'Administration',
];

const bottomNavigation = [
  AppRoute(title: 'Dashboard', path: '/dashboard', icon: Icons.dashboard, group: 'Overview'),
  AppRoute(title: 'Sales', path: '/sales/customers', icon: Icons.point_of_sale, group: 'Sales'),
  AppRoute(title: 'Inventory', path: '/inventory/products', icon: Icons.inventory, group: 'Inventory'),
  AppRoute(title: 'More', path: '/more', icon: Icons.more_horiz, group: 'More'),
];
