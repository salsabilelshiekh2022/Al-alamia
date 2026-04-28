import 'package:alalamia/core/enums/debets_enum.dart';

import '../../../../core/enums/status_enum.dart';
import '../../../expenses/data/models/expense_model.dart';
import '../../../home/data/models/currency_model.dart';
import '../../../notifications/data/models/notification_model.dart';

/// Response structure for paginated debts API
class DebtsResponseModel {
  final List<DebtModel>? debtsList;
  final Meta? meta;
  final bool? success;

  DebtsResponseModel({
    this.debtsList,
    this.meta,
    this.success,
  });

  factory DebtsResponseModel.fromJson(Map<String, dynamic> json) {
    return DebtsResponseModel(
      debtsList: json['data'] != null
          ? (json['data'] as List)
              .map((v) => DebtModel.fromJson(v))
              .toList()
          : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      success: json['success'],
    );
  }
}

class DebtModel {
  int? id;
  String? uuid;
  String? amount;
  StatusEnum? status;
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
    status = json['status'] != null ? StatusEnum.values.firstWhere((e) => e.name == json['status']) : null;
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
  status: StatusEnum.completed,
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

