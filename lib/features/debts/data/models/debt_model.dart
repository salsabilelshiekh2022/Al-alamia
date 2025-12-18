import 'package:alalamia/core/enums/debets_enum.dart';

import '../../../expenses/data/models/expense_model.dart';
import '../../../home/data/models/currency_model.dart';

class DebtModel {
  int? id;
  String? uuid;
  String? amount;
  String? status;
  DateTime? createdAt;
  String? note;
  CurrencyModel? currency;
  EmployeeModel? user;
  EmployeeModel? employee;
  DebetsEnum? type;

  DebtModel({
    this.id,
    this.uuid,
    this.amount,
    this.status,
    this.createdAt,
    this.note,
    this.currency,
    this.user,
    this.type,
    this.employee
  });

  DebtModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    note = json['notes'];
    currency = json['currency'] != null ? CurrencyModel.fromJson(json['currency']) : null;
    user = json['user'] != null ? EmployeeModel.fromJson(json['user']) : null;
    employee = json['employee'] != null ? EmployeeModel.fromJson(json['employee']) : null;
    type = DebetsEnum.values.firstWhere((element) => element.name == json['type']);
  }
}

DebtModel dummyDebtModel = DebtModel(
  id: 1,
  uuid: "uuid",
  amount: "amount",
  status: "status",
  createdAt: DateTime.now(),
  note: "note",
  currency: CurrencyModel(
    id: 1,
    name: "name",
    code: "code",
    image: "image",
  ),
  user: EmployeeModel(
    name: "name",
    phone: "phone",
  ),
  employee: EmployeeModel(
    name: "name",
    phone: "phone",
  ),
  type: DebetsEnum.add_debt
);

