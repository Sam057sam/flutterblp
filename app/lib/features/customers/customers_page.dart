import 'package:flutter/material.dart';

import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/glass_surface.dart';
import '../../shared/widgets/page_header.dart';
import '../../shared/widgets/status_chip.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Customers',
            breadcrumbs: 'Sales / Customers',
            trailing: ElevatedButton.icon(
              onPressed: () => _openCustomerForm(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Customer'),
            ),
            filters: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search customers, tags, or email',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButtonFormField<String>(
                  value: 'Active',
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: const [
                    DropdownMenuItem(value: 'Active', child: Text('Active')),
                    DropdownMenuItem(value: 'Inactive', child: Text('Inactive')),
                  ],
                  onChanged: (_) {},
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_alt),
                  label: const Text('More filters'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Customer Directory',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _TableHeader(),
                const Divider(height: 1),
                for (final customer in _demoCustomers)
                  _CustomerRow(
                    customer: customer,
                    onEdit: () => _openCustomerForm(context),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _EmptyState(),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Text('Customer', style: TextStyle(color: Color(0xFF64748B)))),
        Expanded(child: Text('Contact', style: TextStyle(color: Color(0xFF64748B)))),
        Expanded(child: Text('Credit', style: TextStyle(color: Color(0xFF64748B)))),
        Expanded(child: Text('Status', style: TextStyle(color: Color(0xFF64748B)))),
        SizedBox(width: 72),
      ],
    );
  }
}

class _CustomerRow extends StatelessWidget {
  const _CustomerRow({required this.customer, required this.onEdit});

  final _Customer customer;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(customer.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(customer.company, style: const TextStyle(color: Color(0xFF64748B))),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(customer.email),
                const SizedBox(height: 4),
                Text(customer.phone, style: const TextStyle(color: Color(0xFF64748B))),
              ],
            ),
          ),
          Expanded(child: Text(customer.credit)),
          Expanded(child: StatusChip(label: customer.status, color: customer.statusColor)),
          IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Icon(Icons.people_alt_outlined, size: 56, color: Color(0xFF94A3B8)),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No customer segments configured',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Create segments to track loyalty, location, and lifetime value.'),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Create segment'),
          ),
        ],
      ),
    );
  }
}

void _openCustomerForm(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 720) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _CustomerFormSheet(isFullScreen: true),
    );
  } else {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black26,
      builder: (context) => const Align(
        alignment: Alignment.centerRight,
        child: SizedBox(width: 460, child: _CustomerFormSheet()),
      ),
    );
  }
}

class _CustomerFormSheet extends StatelessWidget {
  const _CustomerFormSheet({this.isFullScreen = false});

  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    final content = GlassSurface(
      borderRadius: isFullScreen ? 28 : 24,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Add Customer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Customer name')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Company')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Email')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Phone')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Billing address')),
          const SizedBox(height: 20),
          Row(
            children: [
              OutlinedButton(onPressed: () {}, child: const Text('Save draft')),
              const SizedBox(width: 12),
              ElevatedButton(onPressed: () {}, child: const Text('Save customer')),
            ],
          ),
        ],
      ),
    );

    if (!isFullScreen) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.only(right: 24, top: 40, bottom: 40),
        child: content,
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: content,
      ),
    );
  }
}

class _Customer {
  const _Customer({
    required this.name,
    required this.company,
    required this.email,
    required this.phone,
    required this.credit,
    required this.status,
    required this.statusColor,
  });

  final String name;
  final String company;
  final String email;
  final String phone;
  final String credit;
  final String status;
  final Color statusColor;
}

const _demoCustomers = [
  _Customer(
    name: 'Sana Sheikh',
    company: 'Atlas Trading',
    email: 'sana@atlas.com',
    phone: '+971 55 210 7751',
    credit: 'AED 120,000',
    status: 'Active',
    statusColor: Color(0xFF10B981),
  ),
  _Customer(
    name: 'Omar Ali',
    company: 'Nova Retail',
    email: 'omar@nova.com',
    phone: '+971 50 885 1173',
    credit: 'AED 44,000',
    status: 'Review',
    statusColor: Color(0xFFF59E0B),
  ),
  _Customer(
    name: 'Fatima Noor',
    company: 'Delta Export',
    email: 'fatima@delta.com',
    phone: '+971 54 110 9055',
    credit: 'AED 210,000',
    status: 'Priority',
    statusColor: Color(0xFF3B82F6),
  ),
];
