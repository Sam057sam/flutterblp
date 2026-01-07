import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/dio_provider.dart';
import '../../core/models/product.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  late Future<List<Product>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<Product>> _load() async {
    final dio = ref.read(dioProvider);
    final response = await dio.get('/api/v1/products');
    final data = response.data['data'] as List? ?? [];
    return data.map((item) => Product.fromJson(item)).toList();
  }

  Future<void> _openForm({Product? product}) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => _ProductFormDialog(product: product),
    );

    if (result == true) {
      setState(() {
        _future = _load();
      });
    }
  }

  Future<void> _delete(Product product) async {
    final dio = ref.read(dioProvider);
    await dio.delete('/api/v1/products/${product.id}');
    setState(() {
      _future = _load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label: const Text('Add Product'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: FutureBuilder<List<Product>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Failed to load products.'));
              }

              final products = snapshot.data ?? [];
              if (products.isEmpty) {
                return const Center(child: Text('No products yet.'));
              }

              return ListView.separated(
                itemCount: products.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.sku ?? 'No SKU'),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _openForm(product: product),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => _delete(product),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ProductFormDialog extends ConsumerStatefulWidget {
  const _ProductFormDialog({this.product});

  final Product? product;

  @override
  ConsumerState<_ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends ConsumerState<_ProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _skuController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _costController = TextEditingController();
  final _stockController = TextEditingController();
  final _unitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final product = widget.product;
    if (product != null) {
      _skuController.text = product.sku ?? '';
      _nameController.text = product.name;
      _priceController.text = product.price?.toString() ?? '';
      _costController.text = product.cost?.toString() ?? '';
      _stockController.text = product.stock?.toString() ?? '';
      _unitController.text = product.unit ?? '';
    }
  }

  @override
  void dispose() {
    _skuController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _costController.dispose();
    _stockController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final dio = ref.read(dioProvider);
    final payload = {
      'sku': _skuController.text,
      'name': _nameController.text,
      'price': _priceController.text,
      'cost': _costController.text,
      'stock': _stockController.text,
      'unit': _unitController.text,
    };

    if (widget.product == null) {
      await dio.post('/api/v1/products', data: payload);
    } else {
      await dio.put('/api/v1/products/${widget.product!.id}', data: payload);
    }

    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _skuController,
                decoration: const InputDecoration(labelText: 'SKU'),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Name is required'
                    : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(labelText: 'Cost'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _stockController,
                decoration: const InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _unitController,
                decoration: const InputDecoration(labelText: 'Unit'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _save,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
