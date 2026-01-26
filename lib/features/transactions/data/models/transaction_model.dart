
import '../../../../core/enums/status_enum.dart';
import '../../../home/data/models/currency_model.dart';
import '../../../notifications/data/models/notification_model.dart';

class TransactionsResponseModel {
  final List<TransactionModel>? transactionsList;
  final Meta? meta;
  final bool? success;

  TransactionsResponseModel({
    this.transactionsList,
    this.meta,
    this.success,
  });

  factory TransactionsResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionsResponseModel(
      transactionsList: json['data'] != null
          ? (json['data'] as List)
              .map((v) => TransactionModel.fromJson(v))
              .toList()
          : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      success: json['success'],
    );
  }
}

class TransactionModel {
  int? id;
  String? transactionUuid;
  String? dateTime;
  StatusEnum? status;
  ClientsFromTo? client;
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
      status:StatusEnum.values.firstWhere((e) => e.name == json['status']),
      client: json['client'] != null ? ClientsFromTo.fromJson(json['client']) : null,
      currency: json['currency'] != null ? CurrencyModel.fromJson(json['currency']) : null,
      amountReceived: json['amount_recieved'],
    );
  }

}


class ClientsFromTo {
  ClientModel? fromClient;
  ClientModel? toClient;

  ClientsFromTo({this.fromClient, this.toClient});

  factory ClientsFromTo.fromJson(Map<String, dynamic> json) {
    return ClientsFromTo(
      fromClient: json['from_client'] != null ? ClientModel.fromJson(json['from_client']) : null,
      toClient: json['to_client'] != null ? ClientModel.fromJson(json['to_client']) : null,
    );
  }
}



class ClientModel {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? phone_2;

  ClientModel({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.phone_2,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      phone_2: json['phone_2'],
    );
  }
}

TransactionModel dummyTransactionModel = TransactionModel(
  id: 1,
  transactionUuid: '1234567890',
  dateTime: DateTime.now().toString(),
  status: StatusEnum.completed,
 client: ClientsFromTo(
    fromClient: ClientModel(
      id: 1,
      name: 'John Doe',
      phone: '+1 234 567 890',
      phone_2: '+1 234 567 891',
      address: '123 Main St, Cityville',
    ),
    toClient: ClientModel(
      id: 2,
      name: 'Jane Smith',
      phone: '+1 987 654 321',
      phone_2: '+1 987 654 322',
      address: '456 Elm St, Townsville',
    ),
  ),
  currency: CurrencyModel(
    id: 1,
    name: 'US Dollar',
    code: 'USD',
    image: "assets/images/currencies/usd.png",
  ),
  amountReceived: '100.00',
);