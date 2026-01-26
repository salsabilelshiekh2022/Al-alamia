import 'package:alalamia/core/enums/status_enum.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import '../../../notifications/data/models/notification_model.dart';

class ExpensesResponseModel {
  final List<ExpenseModel>? expensesList;
  final Meta? meta;
  final bool? success;

  ExpensesResponseModel({
    this.expensesList,
    this.meta,
    this.success,
  });

  factory ExpensesResponseModel.fromJson(Map<String, dynamic> json) {
    return ExpensesResponseModel(
      expensesList: json['data'] != null
          ? (json['data'] as List)
              .map((v) => ExpenseModel.fromJson(v))
              .toList()
          : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      success: json['success'],
    );
  }
}

class ExpenseModel {

  int? id;
  String? uuid;
  String? amount;
  StatusEnum? status;
  DateTime? createdAt;
  String? note;
  CurrencyModel? currency;
  EmployeeModel? employee;

  ExpenseModel({this.id, this.uuid, this.amount, this.status, this.createdAt, this.note, this.currency, this.employee});

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    amount = json['amount'];
    status = StatusEnum.values.firstWhere((e) => e.name == json['status']);
    createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    note = json['notes'];
    currency = json['currency'] != null ? CurrencyModel.fromJson(json['currency']) : null;
    employee = json['employee'] != null ? EmployeeModel.fromJson(json['employee']) : null;
  }

}


class EmployeeModel {

  String? name;
  String? phone;

  EmployeeModel({this.name, this.phone});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }
  }

  ExpenseModel dummyExpenseModel = ExpenseModel(
    id: 1,
    uuid: "uuid",
    amount: "amount",
    status: StatusEnum.completed,
    createdAt: DateTime.now(),
    note: "note",
    currency: CurrencyModel(
      id: 1,
      name: "name",
      code: "code",
      image: "image",
    ),
    employee: EmployeeModel(
      name: "name",
      phone: "phone",
    )
  );

