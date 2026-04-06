class ExpensesTypeModel {
  final int id;
  final String name;

  ExpensesTypeModel({
    required this.id,
    required this.name,
  });

  factory ExpensesTypeModel.fromJson(Map<String, dynamic> json) {
    return ExpensesTypeModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}