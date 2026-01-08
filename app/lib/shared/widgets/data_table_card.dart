import 'package:flutter/material.dart';

import 'glass_card.dart';

class DataTableCard extends StatelessWidget {
  const DataTableCard({
    super.key,
    required this.title,
    required this.columns,
    required this.rows,
    this.trailing,
  });

  final String title;
  final List<String> columns;
  final List<List<Widget>> rows;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.55),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _TableHeader(columns: columns),
                const Divider(height: 1),
                for (final row in rows) _TableRow(cells: row),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({required this.columns});

  final List<String> columns;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          for (final col in columns)
            Expanded(
              child: Text(
                col,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow({required this.cells});

  final List<Widget> cells;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          for (final cell in cells)
            Expanded(child: cell),
        ],
      ),
    );
  }
}
