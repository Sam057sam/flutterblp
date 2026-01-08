import 'package:flutter/material.dart';

import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/glass_surface.dart';
import '../../shared/widgets/page_header.dart';
import '../../shared/widgets/status_chip.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Products',
            breadcrumbs: 'Inventory / Products',
            trailing: ElevatedButton.icon(
              onPressed: () => _openProductForm(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Product'),
            ),
            filters: Row(
              children: [
                DropdownButtonFormField<String>(
                  value: 'All Categories',
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: const [
                    DropdownMenuItem(value: 'All Categories', child: Text('All Categories')),
                    DropdownMenuItem(value: 'Office', child: Text('Office')),
                    DropdownMenuItem(value: 'Electronics', child: Text('Electronics')),
                  ],
                  onChanged: (_) {},
                ),
                const SizedBox(width: 12),
                DropdownButtonFormField<String>(
                  value: 'All Brands',
                  decoration: const InputDecoration(labelText: 'Brand'),
                  items: const [
                    DropdownMenuItem(value: 'All Brands', child: Text('All Brands')),
                    DropdownMenuItem(value: 'Canon', child: Text('Canon')),
                    DropdownMenuItem(value: 'HP', child: Text('HP')),
                  ],
                  onChanged: (_) {},
                ),
                const SizedBox(width: 12),
                DropdownButtonFormField<String>(
                  value: 'Main Warehouse',
                  decoration: const InputDecoration(labelText: 'Warehouse'),
                  items: const [
                    DropdownMenuItem(value: 'Main Warehouse', child: Text('Main Warehouse')),
                    DropdownMenuItem(value: 'Dubai', child: Text('Dubai')),
                  ],
                  onChanged: (_) {},
                ),
                const SizedBox(width: 12),
                DropdownButtonFormField<String>(
                  value: 'All Stock',
                  decoration: const InputDecoration(labelText: 'Stock Status'),
                  items: const [
                    DropdownMenuItem(value: 'All Stock', child: Text('All Stock')),
                    DropdownMenuItem(value: 'Low', child: Text('Low')),
                    DropdownMenuItem(value: 'Reorder', child: Text('Reorder')),
                  ],
                  onChanged: (_) {},
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
                  'Inventory Catalog',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _TableHeader(),
                const Divider(height: 1),
                for (final product in _demoProducts)
                  _ProductRow(product: product, onEdit: () => _openProductForm(context)),
              ],
            ),
          ),
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
        Expanded(child: Text('Product', style: TextStyle(color: Color(0xFF64748B)))),
        Expanded(child: Text('SKU', style: TextStyle(color: Color(0xFF64748B)))),
        Expanded(child: Text('Stock', style: TextStyle(color: Color(0xFF64748B)))),
        Expanded(child: Text('Warehouse', style: TextStyle(color: Color(0xFF64748B)))),
        Expanded(child: Text('Status', style: TextStyle(color: Color(0xFF64748B)))),
        SizedBox(width: 72),
      ],
    );
  }
}

class _ProductRow extends StatelessWidget {
  const _ProductRow({required this.product, required this.onEdit});

  final _Product product;
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
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(product.category, style: const TextStyle(color: Color(0xFF64748B))),
              ],
            ),
          ),
          Expanded(child: Text(product.sku)),
          Expanded(child: Text(product.stock)),
          Expanded(child: Text(product.warehouse)),
          Expanded(child: StatusChip(label: product.status, color: product.statusColor)),
          IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
        ],
      ),
    );
  }
}

void _openProductForm(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 720) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _ProductFormSheet(isFullScreen: true),
    );
  } else {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black26,
      builder: (context) => const Align(
        alignment: Alignment.centerRight,
        child: SizedBox(width: 460, child: _ProductFormSheet()),
      ),
    );
  }
}

class _ProductFormSheet extends StatelessWidget {
  const _ProductFormSheet({this.isFullScreen = false});

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
                'Add Product',
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
          const TextField(decoration: InputDecoration(labelText: 'Product name')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'SKU')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Category')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Brand')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Unit price')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Reorder level')),
          const SizedBox(height: 20),
          Row(
            children: [
              OutlinedButton(onPressed: () {}, child: const Text('Save draft')),
              const SizedBox(width: 12),
              ElevatedButton(onPressed: () {}, child: const Text('Save product')),
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

class _Product {
  const _Product({
    required this.name,
    required this.category,
    required this.sku,
    required this.stock,
    required this.warehouse,
    required this.status,
    required this.statusColor,
  });

  final String name;
  final String category;
  final String sku;
  final String stock;
  final String warehouse;
  final String status;
  final Color statusColor;
}

const _demoProducts = [
  _Product(
    name: 'Laser Printer',
    category: 'Electronics',
    sku: 'PR-2201',
    stock: '42 units',
    warehouse: 'Main Warehouse',
    status: 'Healthy',
    statusColor: Color(0xFF10B981),
  ),
  _Product(
    name: 'Packaging Boxes',
    category: 'Logistics',
    sku: 'BX-1190',
    stock: '12 units',
    warehouse: 'Dubai',
    status: 'Reorder',
    statusColor: Color(0xFFEF4444),
  ),
  _Product(
    name: 'Copy Paper A4',
    category: 'Office',
    sku: 'OF-3302',
    stock: '24 packs',
    warehouse: 'Main Warehouse',
    status: 'Low',
    statusColor: Color(0xFFF59E0B),
  ),
];
