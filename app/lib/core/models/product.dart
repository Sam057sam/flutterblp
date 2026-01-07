class Product {
  Product({
    required this.id,
    required this.name,
    this.sku,
    this.description,
    this.price,
    this.cost,
    this.stock,
    this.unit,
  });

  final int id;
  final String name;
  final String? sku;
  final String? description;
  final double? price;
  final double? cost;
  final int? stock;
  final String? unit;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name']?.toString() ?? '',
      sku: json['sku']?.toString(),
      description: json['description']?.toString(),
      price: double.tryParse(json['price']?.toString() ?? ''),
      cost: double.tryParse(json['cost']?.toString() ?? ''),
      stock: int.tryParse(json['stock']?.toString() ?? ''),
      unit: json['unit']?.toString(),
    );
  }
}
