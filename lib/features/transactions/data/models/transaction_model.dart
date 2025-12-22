//  {
//             "id": 204,
//             "transaction_uuid": "code_204_120727",
//             "date_time": "2025-12-22 12:07:27",
//             "status": "approved",
//             "client": {
//                 "from_client": {
//                     "id": 16,
//                     "name": "علي محمد",
//                     "phone": "010123456879",
//                     "address": "طرابلس"
//                 },
//                 "to_client": {
//                     "id": 17,
//                     "name": "محمد علي",
//                     "phone": "010123456877",
//                     "address": "بني غازي"
//                 }
//             },
//             "currency": {
//                 "id": 2,
//                 "name": "الدولار الأمريكي",
//                 "code": "USD",
//                 "image": "https://upload.wikimedia.org/wikipedia/en/a/a4/Flag_of_the_United_States.svg"
//             },
//             "amount_recieved": "0.24"
//         },

import 'package:alalamia/core/enums/status_enum.dart';

import '../../../home/data/models/currency_model.dart';

class TransactionModel {
  int? id;
  String? transactionUuid;
  String? dateTime;
  StatusEnum? status;
  ClientModel? client;
  CurrencyModel? currency;
  String? amountReceived;

  TransactionModel({
    this.id,
    this.transactionUuid,
    this.dateTime,
    this.status,
    this.client,
    this.currency,
    this.amountReceived,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      transactionUuid: json['transaction_uuid'],
      dateTime: json['date_time'],
      status: StatusEnum.values.firstWhere((element) => element.name == json['status']),
      client: json['client'] != null ? ClientModel.fromJson(json['client']) : null,
      currency: json['currency'] != null ? CurrencyModel.fromJson(json['currency']) : null,
      amountReceived: json['amount_recieved'],
    );
  }
}

class ClientModel {
  int? id;
  String? name;
  String? phone;
  String? address;

  ClientModel({
    this.id,
    this.name,
    this.phone,
    this.address,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}