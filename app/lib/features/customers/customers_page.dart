import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/dio_provider.dart';
import '../../core/models/customer.dart';

class CustomersPage extends ConsumerStatefulWidget {
  const CustomersPage({super.key});

  @override
  ConsumerState<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends ConsumerState<CustomersPage> {
  late Future<List<Customer>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<Customer>> _load() async {
    final dio = ref.read(dioProvider);
    final response = await dio.get('/api/v1/customers');
    final data = response.data['data'] as List? ?? [];
    return data.map((item) => Customer.fromJson(item)).toList();
  }

  Future<void> _openForm({Customer? customer}) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => _CustomerFormDialog(customer: customer),
    );

    if (result == true) {
      setState(() {
        _future = _load();
      });
    }
  }

  Future<void> _delete(Customer customer) async {
    final dio = ref.read(dioProvider);
    await dio.delete('/api/v1/customers/${customer.id}');
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
              'Customers',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label: const Text('Add Customer'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: FutureBuilder<List<Customer>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Failed to load customers.'));
              }

              final customers = snapshot.data ?? [];
              if (customers.isEmpty) {
                return const Center(child: Text('No customers yet.'));
              }

              return ListView.separated(
                itemCount: customers.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final customer = customers[index];
                  return ListTile(
                    title: Text(customer.name),
                    subtitle: Text(customer.email ?? 'No email'),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _openForm(customer: customer),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => _delete(customer),
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

class _CustomerFormDialog extends ConsumerStatefulWidget {
  const _CustomerFormDialog({this.customer});

  final Customer? customer;

  @override
  ConsumerState<_CustomerFormDialog> createState() => _CustomerFormDialogState();
}

class _CustomerFormDialogState extends ConsumerState<_CustomerFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final customer = widget.customer;
    if (customer != null) {
      _nameController.text = customer.name;
      _emailController.text = customer.email ?? '';
      _phoneController.text = customer.phone ?? '';
      _addressController.text = customer.address ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final dio = ref.read(dioProvider);
    final payload = {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
    };

    if (widget.customer == null) {
      await dio.post('/api/v1/customers', data: payload);
    } else {
      await dio.put('/api/v1/customers/${widget.customer!.id}', data: payload);
    }

    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.customer == null ? 'Add Customer' : 'Edit Customer'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Name is required'
                    : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
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
