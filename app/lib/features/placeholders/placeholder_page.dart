import 'package:flutter/material.dart';

import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/page_header.dart';

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({
    super.key,
    required this.title,
    required this.breadcrumbs,
  });

  final String title;
  final String breadcrumbs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: title,
            breadcrumbs: breadcrumbs,
            trailing: ElevatedButton(
              onPressed: () {},
              child: const Text('Add new'),
            ),
            filters: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Filter by status, tags, or owner',
                      prefixIcon: Icon(Icons.filter_alt),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.tune),
                  label: const Text('Advanced filters'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GlassCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Icon(Icons.layers_outlined, size: 56, color: Color(0xFF94A3B8)),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Coming soon',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'We are building this module. In the meantime, set up your data foundations.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Review setup checklist'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
