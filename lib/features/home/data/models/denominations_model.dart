class DenominationsModel {
  String? name;
  String? value;
  num? quantity;
  num? total;

  DenominationsModel({this.name, this.value, this.quantity, this.total});

  DenominationsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    quantity = json['quantity'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['quantity'] = quantity;
    data['total'] = total;
    return data;
  }
}

List<DenominationsModel> get dummyDenominations => List.generate(
  6,
  (index) => DenominationsModel(
    name: 'Denomination ${index + 1}',
    value: '\$${(index + 1) * 100}',
    quantity: 10,
    total: (index + 1) * 1000,
  ),
);
