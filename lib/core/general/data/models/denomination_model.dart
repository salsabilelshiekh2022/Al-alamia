class DenominationModel {
  int? id;
  String? name;
  String? value;

  DenominationModel({this.id, this.name, this.value});

  DenominationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }
}
