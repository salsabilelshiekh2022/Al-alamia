import 'package:alalamia/core/enums/commission_type_enum.dart';
import 'package:alalamia/core/enums/delivery_type_enum.dart';
import 'package:alalamia/features/transactions/data/models/transaction_model.dart';

import '../../../../core/enums/status_enum.dart';
import '../../../../core/general/data/models/branch_model.dart';

class TransactionDetailsModel {
  TransactionDetailsModel({
     this.amount,
     this.amountSent,
     this.currency,
     this.amountReceived,
     this.toCurrency,
     this.fromBranch,
     this.toBranch,
     this.sender,
     this.receiver,
     this.details,
    this.paymentMethod,
    this.pdfUrl,
     this.recievingBranch,
    this.recieveType,
    this.notes,
  });

  final String? amountSent;
  final String? amount;
  final String? currency;
  final String? amountReceived;
  final String? toCurrency;
  final BranchModel? fromBranch;
  final BranchModel? toBranch;
  final ClientModel? sender;
  final ClientModel? receiver;
  final DetailModel? details;
  final PaymentMethodModel? paymentMethod;
  final String? pdfUrl;
  final bool? recievingBranch;
  final DeliveryTypeEnum? recieveType;
  final String? notes;

  factory TransactionDetailsModel.fromJson(
    Map<String, dynamic> json, {
    String? pdfUrl,
  }) => TransactionDetailsModel(
    amountSent: json["amount_sent"],
    amount: json["amount"],
    currency: json["currency"],
    amountReceived: json["amount_received"],
    toCurrency: json["ToCurrency"],
    fromBranch: BranchModel.fromJson(json["from_branch"]),
    toBranch: BranchModel.fromJson(json["to_branch"]),
    sender:json["sender"] != null ? ClientModel.fromJson(json["sender"]) : null,
    receiver: json["receiver"] != null ? ClientModel.fromJson(json["receiver"]) : null,
    details:json["details"] != null ? DetailModel.fromJson(json["details"]) : null,
    pdfUrl: pdfUrl,
    recievingBranch:json["recieving_branch"] != null ? json["recieving_branch"] as bool : null,
    recieveType: json["recieve_type"] != null
        ? DeliveryTypeEnum.values.firstWhere(
            (e) => e.name == json['recieve_type'],
          )
        : null,
    notes: json["notes"],
    paymentMethod: json["payment_method"] != null
        ? PaymentMethodModel.fromJson(json["payment_method"])
        : null,
  );
}

class DetailModel {
  DetailModel({
     this.transactionUuid,
     this.transactionType,
     this.totalCommissionValue,
     this.amountSent,
     this.amountCharacter,
     this.exchangeRate,
     this.transferFees,
     this.totalAmount,
     this.commissionType,
     this.status,
     this.dateTime,
  });

  final String? transactionUuid;
  final String? transactionType;
  final String? totalCommissionValue;
  final String? amountSent;
  final String? amountCharacter;
  final String? exchangeRate;
  final int? transferFees;
  final double? totalAmount;
  final CommissionTypeEnum? commissionType;
  final StatusEnum? status;
  final DateTime? dateTime;

  factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
    transactionUuid: json["transaction_uuid"],
    transactionType: json["transaction_type"],
    totalCommissionValue: json["total_commission_value"],
    amountSent: json["amount_sent"],
    amountCharacter: json["amount_character"],
    exchangeRate: json["exchange_rate"],
    transferFees: json["transfer_fees"],
    totalAmount: json["total_amount"] != null ? json["total_amount"].toDouble() : null,
    commissionType: json["commission_type"] != null
        ? CommissionTypeEnum.values.firstWhere(
            (e) => e.name == json['commission_type'],
          )
        : null,
    status: json["status"] != null
        ? StatusEnum.values.firstWhere(
            (e) => e.name == json['status'],
          )
        : null,
    dateTime: json["date_time"] != null ? DateTime.parse(json["date_time"]) : null,
  );
}
class PaymentMethodModel {
  PaymentMethodModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) => PaymentMethodModel(
    id: json["id"],
    name: json["name"],
  );
}

TransactionDetailsModel dummyTransactionModel = TransactionDetailsModel(
  amountSent: '9.20',
  currency: 'USD',
  amountReceived: '10.399999999999999',
  toCurrency: 'الدولار الأمريكي',
  fromBranch: dummyBranchModel,
  toBranch: dummyBranchModel,
  recievingBranch: false,
  sender: ClientModel(
    id: 16,
    name: 'علي محمد',
    phone: '010123456879',
    address: 'طرابلس',
  ),
  receiver: ClientModel(
    id: 17,
    name: 'محمد علي',
    phone: '010123456877',
    address: 'بني غازي',
  ),
  details: DetailModel(
    transactionUuid: 'code_204_120727',
    transactionType: 'sending',
    totalCommissionValue: '1.20',
    amountSent: '9.20',
    amountCharacter: 'خمسمائه وخمسه وخمسون',
    exchangeRate: '0.0305',
    transferFees: 0,
    totalAmount: 10.399999999999999,
    commissionType: CommissionTypeEnum.none,
    status: StatusEnum.completed,
    dateTime: DateTime.now(),
  ),
);

BranchModel dummyBranchModel = BranchModel(
  id: 1,
  name: 'فرع زلتين',
  transferFee: 0,
  commissionRatePercentage: '10',
);
