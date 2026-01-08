import 'package:flutter/material.dart';

import '../../shared/widgets/data_table_card.dart';
import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/kpi_card.dart';
import '../../shared/widgets/page_header.dart';
import '../../shared/widgets/status_chip.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Dashboard',
            breadcrumbs: 'Overview / Dashboard',
            trailing: Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download),
                  label: const Text('Export'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Create report'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 980;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: isNarrow ? constraints.maxWidth : (constraints.maxWidth - 32) / 3,
                    child: const KpiCard(
                      title: 'Today Sales',
                      value: 'AED 84,230',
                      delta: '+12.4% vs yesterday',
                      icon: Icons.trending_up,
                    ),
                  ),
                  SizedBox(
                    width: isNarrow ? constraints.maxWidth : (constraints.maxWidth - 32) / 3,
                    child: const KpiCard(
                      title: 'Month Revenue',
                      value: 'AED 1.24M',
                      delta: '+6.8% vs last month',
                      icon: Icons.stacked_line_chart,
                    ),
                  ),
                  SizedBox(
                    width: isNarrow ? constraints.maxWidth : (constraints.maxWidth - 32) / 3,
                    child: const KpiCard(
                      title: 'Receivables',
                      value: 'AED 312,000',
                      delta: '32 invoices due',
                      icon: Icons.account_balance_wallet,
                    ),
                  ),
                  SizedBox(
                    width: isNarrow ? constraints.maxWidth : (constraints.maxWidth - 32) / 3,
                    child: const KpiCard(
                      title: 'Payables',
                      value: 'AED 198,500',
                      delta: '18 bills pending',
                      icon: Icons.request_quote,
                    ),
                  ),
                  SizedBox(
                    width: isNarrow ? constraints.maxWidth : (constraints.maxWidth - 32) / 3,
                    child: const KpiCard(
                      title: 'Low Stock',
                      value: '14 SKUs',
                      delta: 'Reorder alerts active',
                      icon: Icons.warning_amber,
                    ),
                  ),
                  SizedBox(
                    width: isNarrow ? constraints.maxWidth : (constraints.maxWidth - 32) / 3,
                    child: const KpiCard(
                      title: 'Overdue Invoices',
                      value: 'AED 42,700',
                      delta: '7 invoices overdue',
                      icon: Icons.timelapse,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final isStacked = constraints.maxWidth < 1000;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: isStacked ? constraints.maxWidth : (constraints.maxWidth - 16) / 2,
                    child: const _ChartCard(
                      title: 'Sales trend',
                      subtitle: 'Last 30 days',
                    ),
                  ),
                  SizedBox(
                    width: isStacked ? constraints.maxWidth : (constraints.maxWidth - 16) / 2,
                    child: const _ChartCard(
                      title: 'Profit vs Expense',
                      subtitle: 'Year to date',
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final isStacked = constraints.maxWidth < 1100;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: isStacked ? constraints.maxWidth : (constraints.maxWidth - 16) / 2,
                    child: DataTableCard(
                      title: 'Recent invoices',
                      columns: const ['Invoice', 'Customer', 'Amount', 'Status'],
                      rows: [
                        [
                          const Text('INV-1002'),
                          const Text('Atlas Trading'),
                          const Text('AED 24,200'),
                          const StatusChip(label: 'Pending', color: Color(0xFFF59E0B)),
                        ],
                        [
                          const Text('INV-1001'),
                          const Text('Delta Export'),
                          const Text('AED 18,500'),
                          const StatusChip(label: 'Paid', color: Color(0xFF10B981)),
                        ],
                        [
                          const Text('INV-0998'),
                          const Text('Nova Retail'),
                          const Text('AED 7,300'),
                          const StatusChip(label: 'Overdue', color: Color(0xFFEF4444)),
                        ],
                      ],
                      trailing: TextButton(
                        onPressed: () {},
                        child: const Text('View all'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: isStacked ? constraints.maxWidth : (constraints.maxWidth - 16) / 2,
                    child: DataTableCard(
                      title: 'Low stock items',
                      columns: const ['SKU', 'Product', 'On Hand', 'Status'],
                      rows: [
                        [
                          const Text('SKU-1009'),
                          const Text('A4 Copy Paper'),
                          const Text('12 packs'),
                          const StatusChip(label: 'Reorder', color: Color(0xFFEF4444)),
                        ],
                        [
                          const Text('SKU-2210'),
                          const Text('Printer Toner'),
                          const Text('8 units'),
                          const StatusChip(label: 'Low', color: Color(0xFFF59E0B)),
                        ],
                        [
                          const Text('SKU-7877'),
                          const Text('Packaging Boxes'),
                          const Text('24 units'),
                          const StatusChip(label: 'Watch', color: Color(0xFF3B82F6)),
                        ],
                      ],
                      trailing: TextButton(
                        onPressed: () {},
                        child: const Text('Reorder list'),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Color(0xFF64748B))),
          const SizedBox(height: 16),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.55),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(Icons.show_chart, size: 48, color: Color(0xFF94A3B8)),
            ),
          ),
        ],
      ),
    );
  }
}
