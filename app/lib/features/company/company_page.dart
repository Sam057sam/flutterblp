import 'package:flutter/material.dart';

import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/glass_surface.dart';
import '../../shared/widgets/page_header.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Company Profile',
            breadcrumbs: 'Operations / Company',
            trailing: Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility),
                  label: const Text('Preview'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.save),
                  label: const Text('Save Changes'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _Section(
            title: 'Identity',
            subtitle: 'Branding & legal profile',
            child: _TwoColumn(
              children: [
                const TextField(decoration: InputDecoration(labelText: 'Entity code')),
                const TextField(decoration: InputDecoration(labelText: 'Display name')),
                const TextField(decoration: InputDecoration(labelText: 'Legal name')),
                const TextField(decoration: InputDecoration(labelText: 'Reporting currency')),
                const TextField(decoration: InputDecoration(labelText: 'Primary email')),
                const TextField(decoration: InputDecoration(labelText: 'Contact phone')),
                const TextField(decoration: InputDecoration(labelText: 'Street address')),
                const TextField(decoration: InputDecoration(labelText: 'City')),
                const TextField(decoration: InputDecoration(labelText: 'State / Region')),
                const TextField(decoration: InputDecoration(labelText: 'Postal code')),
                DropdownButtonFormField<String>(
                  value: 'United Arab Emirates',
                  decoration: const InputDecoration(labelText: 'Country'),
                  items: const [
                    DropdownMenuItem(value: 'United Arab Emirates', child: Text('United Arab Emirates')),
                    DropdownMenuItem(value: 'India', child: Text('India')),
                    DropdownMenuItem(value: 'Saudi Arabia', child: Text('Saudi Arabia')),
                  ],
                  onChanged: (_) {},
                ),
                const TextField(decoration: InputDecoration(labelText: 'Tagline')),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _Section(
            title: 'Branding',
            subtitle: 'Visual identity',
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: const [
                _UploadCard(title: 'Logo', helper: 'SVG / PNG 512x512'),
                _UploadCard(title: 'Favicon', helper: 'PNG 64x64'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _Section(
            title: 'Compliance',
            subtitle: 'Registrations & filings',
            child: _TwoColumn(
              children: [
                const TextField(decoration: InputDecoration(labelText: 'GST / VAT number')),
                const TextField(decoration: InputDecoration(labelText: 'Tax registration')),
                const TextField(decoration: InputDecoration(labelText: 'PAN / Tax ID')),
                const TextField(decoration: InputDecoration(labelText: 'CIN / Company ID')),
                const TextField(decoration: InputDecoration(labelText: 'MSME / Udyam')),
                const TextField(
                  maxLines: 3,
                  decoration: InputDecoration(labelText: 'Compliance notes'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _Section(
            title: 'Workspace defaults',
            subtitle: 'Account metadata',
            child: _TwoColumn(
              children: [
                DropdownButtonFormField<String>(
                  value: 'Asia/Dubai',
                  decoration: const InputDecoration(labelText: 'Timezone'),
                  items: const [
                    DropdownMenuItem(value: 'Asia/Dubai', child: Text('Asia/Dubai')),
                    DropdownMenuItem(value: 'Asia/Kolkata', child: Text('Asia/Kolkata')),
                    DropdownMenuItem(value: 'UTC', child: Text('UTC')),
                  ],
                  onChanged: (_) {},
                ),
                DropdownButtonFormField<String>(
                  value: 'en-AE',
                  decoration: const InputDecoration(labelText: 'Locale'),
                  items: const [
                    DropdownMenuItem(value: 'en-AE', child: Text('en-AE')),
                    DropdownMenuItem(value: 'en-IN', child: Text('en-IN')),
                    DropdownMenuItem(value: 'en-US', child: Text('en-US')),
                  ],
                  onChanged: (_) {},
                ),
                const TextField(decoration: InputDecoration(labelText: 'Industry')),
                const TextField(decoration: InputDecoration(labelText: 'Financial year start')),
                const TextField(decoration: InputDecoration(labelText: 'Financial year end')),
                const TextField(decoration: InputDecoration(labelText: 'Document prefix')),
                const TextField(decoration: InputDecoration(labelText: 'Website')),
                const TextField(decoration: InputDecoration(labelText: 'Support email')),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _Section(
            title: 'Finance',
            subtitle: 'Bank details & terms',
            child: _TwoColumn(
              children: [
                const TextField(decoration: InputDecoration(labelText: 'Account name')),
                const TextField(decoration: InputDecoration(labelText: 'Account number')),
                const TextField(decoration: InputDecoration(labelText: 'Bank')),
                const TextField(decoration: InputDecoration(labelText: 'Branch')),
                const TextField(decoration: InputDecoration(labelText: 'IFSC code')),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _Section(
            title: 'Documents',
            subtitle: 'Watermark, signature & terms',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: const [
                    _UploadCard(title: 'Document watermark', helper: 'PNG / PDF 1024px wide'),
                    _UploadCard(title: 'Authorised signatory signature', helper: 'PNG transparent'),
                  ],
                ),
                const SizedBox(height: 16),
                const TextField(
                  maxLines: 6,
                  decoration: InputDecoration(labelText: 'Terms & conditions'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          GlassCard(
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Remember to keep your legal profile and tax IDs up to date for compliance audits.',
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Mark profile as reviewed'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.subtitle, required this.child});

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Color(0xFF64748B))),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _TwoColumn extends StatelessWidget {
  const _TwoColumn({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 780;
        if (isNarrow) {
          return Column(
            children: [
              for (final child in children) ...[
                child,
                const SizedBox(height: 12),
              ],
            ],
          );
        }
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final child in children)
              SizedBox(width: (constraints.maxWidth - 16) / 2, child: child),
          ],
        );
      },
    );
  }
}

class _UploadCard extends StatelessWidget {
  const _UploadCard({required this.title, required this.helper});

  final String title;
  final String helper;

  @override
  Widget build(BuildContext context) {
    return GlassSurface(
      borderRadius: 18,
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(helper, style: const TextStyle(color: Color(0xFF64748B))),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
