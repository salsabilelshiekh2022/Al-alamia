class PaymentMethodModel {
  final int id;
  final String name;
  final String? image;

  PaymentMethodModel({
    required this.id,
    required this.name,
     this.image,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
