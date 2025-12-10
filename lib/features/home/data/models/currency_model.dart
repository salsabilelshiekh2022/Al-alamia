class CurrencyModel {
  final int? id;
  final String? name;
  final String? code;
  final String? image;

  CurrencyModel({this.id, this.name, this.code, this.image});

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['image'] = image;
    return data;
  }
}
