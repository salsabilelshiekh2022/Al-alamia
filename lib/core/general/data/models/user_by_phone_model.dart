class UserByPhoneModel {
  final int? id;
  final String? name;
  final String? phone;
  final String? phone2;
  final String? address;

  UserByPhoneModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.phone2,
    required this.address,
  });

  factory UserByPhoneModel.fromJson(Map<String, dynamic> json) {
    return UserByPhoneModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      phone2: json['phone_2'],
      address: json['address'],
    );
  }
}
