import 'package:flutter/material.dart';

import 'glass_surface.dart';

class GlassTopBar extends StatelessWidget {
  const GlassTopBar({
    super.key,
    required this.breadcrumbs,
    required this.onToggleSidebar,
    required this.onToggleRightPanel,
  });

  final List<String> breadcrumbs;
  final VoidCallback onToggleSidebar;
  final VoidCallback onToggleRightPanel;

  @override
  Widget build(BuildContext context) {
    return GlassSurface(
      borderRadius: 24,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: onToggleSidebar,
          ),
          const SizedBox(width: 8),
          _Breadcrumbs(items: breadcrumbs),
          const Spacer(),
          SizedBox(
            width: 260,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search invoices, customers, products',
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                filled: true,
                fillColor: Colors.white.withOpacity(0.7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.receipt_long),
            label: const Text('New Invoice'),
          ),
          const SizedBox(width: 12),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.person_add_alt),
            label: const Text('New Customer'),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: onToggleRightPanel,
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFDBEAFE),
            child: Text('SA', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}


class GlassTopBarCompact extends StatelessWidget {
  const GlassTopBarCompact({
    super.key,
    required this.breadcrumbs,
    required this.onOpenDrawer,
  });

  final List<String> breadcrumbs;
  final VoidCallback onOpenDrawer;

  @override
  Widget build(BuildContext context) {
    return GlassSurface(
      borderRadius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: onOpenDrawer,
          ),
          const SizedBox(width: 8),
          Expanded(child: _Breadcrumbs(items: breadcrumbs)),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.add_circle_outline),
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'invoice', child: Text('New Invoice')),
              PopupMenuItem(value: 'customer', child: Text('New Customer')),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          const CircleAvatar(
            radius: 14,
            backgroundColor: Color(0xFFDBEAFE),
            child: Text('SA', style: TextStyle(fontSize: 10)),
          ),
        ],
      ),
    );
  }
}

class _Breadcrumbs extends StatelessWidget {
  const _Breadcrumbs({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          Text(
            items[i],
            style: TextStyle(
              fontWeight: i == items.length - 1 ? FontWeight.bold : FontWeight.w500,
              color: i == items.length - 1
                  ? const Color(0xFF0F172A)
                  : const Color(0xFF64748B),
            ),
          ),
          if (i != items.length - 1)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Icon(Icons.chevron_right, size: 16, color: Color(0xFF94A3B8)),
            ),
        ],
      ],
    );
  }
}
