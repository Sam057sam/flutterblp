class UserProfile {
  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    this.companyName,
  });

  final int id;
  final String name;
  final String email;
  final List<String> roles;
  final String? companyName;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final roles = <String>[];
    final roleList = json['roles'];
    if (roleList is List) {
      for (final role in roleList) {
        if (role is Map && role['name'] != null) {
          roles.add(role['name'].toString());
        }
      }
    }

    final company = json['current_company'] ?? json['currentCompany'];

    return UserProfile(
      id: json['id'] as int,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      roles: roles,
      companyName: company is Map ? company['name']?.toString() : null,
    );
  }
}
