class Customer {
  Customer({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.address,
    this.status,
  });

  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final String? status;

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as int,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      address: json['address']?.toString(),
      status: json['status']?.toString(),
    );
  }
}
