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
