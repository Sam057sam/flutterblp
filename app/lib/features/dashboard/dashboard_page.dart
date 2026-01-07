import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/dio_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  Future<Map<String, dynamic>> _load(Dio dio) async {
    final response = await dio.get('/api/v1/dashboard/kpis');
    return response.data as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dio = ref.watch(dioProvider);

    return FutureBuilder<Map<String, dynamic>>(
      future: _load(dio),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Failed to load KPIs.'));
        }

        final data = snapshot.data ?? {};
        final kpis = (data['kpis'] as Map?) ?? {};
        final alerts = (data['alerts'] as List?) ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _KpiCard(title: 'Customers', value: '${kpis['customers'] ?? 0}'),
                _KpiCard(title: 'Products', value: '${kpis['products'] ?? 0}'),
                _KpiCard(title: 'Sales', value: '${kpis['sales'] ?? 0}'),
                _KpiCard(
                  title: 'Outstanding',
                  value: '${kpis['outstanding_invoices'] ?? 0}',
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Alerts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            for (final alert in alerts)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.notification_important),
                  title: Text(alert['message']?.toString() ?? 'Alert'),
                  subtitle: Text(alert['type']?.toString() ?? 'info'),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Color(0xFF64748B))),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
