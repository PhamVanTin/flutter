class Users {
  final String? email;
  final String? role;
  final String? name;
  final String? address;
  final String? phone;
  Users({
    this.email,
    this.role,
    this.name,
    this.address,
    this.phone,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      email: '',
      role: map['role'],
      name: map['name'],
      address: map['address'],
      phone: map['phone'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'name': name,
      'address': address,
      'phone': phone,
    };
  }
}
