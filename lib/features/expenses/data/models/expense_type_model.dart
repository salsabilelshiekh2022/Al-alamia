class ExpenseTypeModel {
  int id;
  String name;

  ExpenseTypeModel({required this.id, required this.name});

  factory ExpenseTypeModel.fromJson(Map<String, dynamic> json) {
    return ExpenseTypeModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}