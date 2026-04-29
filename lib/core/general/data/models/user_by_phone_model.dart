class UserByPhoneModel {
  final int? id;
  final String? name;
  final String? phone;
  final String? phone2;
  final String? address;
  final String? whatsappNumber;

   UserByPhoneModel({
    this.id,
    this.name,
    this.phone,
    this.phone2,
    this.address,
    this.whatsappNumber,
  });

  factory UserByPhoneModel.fromJson(Map<String, dynamic> json) {
    return UserByPhoneModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      phone2: json['phone_2'],
      address: json['address'],
      whatsappNumber: json['whatsapp_number'],
    );
  }
}
