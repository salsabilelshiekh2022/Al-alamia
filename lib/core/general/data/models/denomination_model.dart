class DenominationModel {
  int? id;
  String? name;

  DenominationModel({this.id, this.name});

  DenominationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
