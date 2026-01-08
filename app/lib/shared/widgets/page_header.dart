import 'package:flutter/material.dart';

import 'glass_card.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    required this.breadcrumbs,
    this.trailing,
    this.filters,
  });

  final String title;
  final String breadcrumbs;
  final Widget? trailing;
  final Widget? filters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          breadcrumbs.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                letterSpacing: 1.2,
                color: const Color(0xFF64748B),
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        if (filters != null) ...[
          const SizedBox(height: 16),
          GlassCard(child: filters!),
        ],
      ],
    );
  }
}
