import 'package:alalamia/core/enums/commission_type_enum.dart';
import 'package:alalamia/core/enums/delivery_type_enum.dart';
import 'package:alalamia/features/transactions/data/models/transaction_model.dart';

import '../../../../core/enums/status_enum.dart';
import '../../../../core/general/data/models/branch_model.dart';

class TransactionDetailsModel {
  TransactionDetailsModel({
    required this.amountSent,
    required this.currency,
    required this.amountReceived,
    required this.toCurrency,
    required this.fromBranch,
    required this.toBranch,
    required this.sender,
    required this.receiver,
    required this.details,
    this.pdfUrl,
    required this.recievingBranch,
    this.recieveType,
    this.notes,
  });

  final String amountSent;
  final String currency;
  final String amountReceived;
  final String toCurrency;
  final BranchModel fromBranch;
  final BranchModel toBranch;
  final ClientModel sender;
  final ClientModel receiver;
  final DetailModel details;
  final String? pdfUrl;
  final bool recievingBranch;
  final DeliveryTypeEnum? recieveType;
  final String? notes;

  factory TransactionDetailsModel.fromJson(
    Map<String, dynamic> json, {
    String? pdfUrl,
  }) => TransactionDetailsModel(
    amountSent: json["amount_sent"],
    currency: json["currency"],
    amountReceived: json["amount_received"],
    toCurrency: json["ToCurrency"],
    fromBranch: BranchModel.fromJson(json["from_branch"]),
    toBranch: BranchModel.fromJson(json["to_branch"]),
    sender: ClientModel.fromJson(json["sender"]),
    receiver: ClientModel.fromJson(json["receiver"]),
    details: DetailModel.fromJson(json["details"]),
    pdfUrl: pdfUrl,
    recievingBranch: json["recieving_branch"],
    recieveType: json["recieve_type"] != null
        ? DeliveryTypeEnum.values.firstWhere(
            (e) => e.name == json['recieve_type'],
          )
        : null,
    notes: json["notes"],
  );
}

class DetailModel {
  DetailModel({
    required this.transactionUuid,
    required this.transactionType,
    required this.totalCommissionValue,
    required this.amountSent,
    required this.amountCharacter,
    required this.exchangeRate,
    required this.transferFees,
    required this.totalAmount,
    required this.commissionType,
    required this.status,
  });

  final String transactionUuid;
  final String transactionType;
  final String totalCommissionValue;
  final String amountSent;
  final String amountCharacter;
  final String exchangeRate;
  final int transferFees;
  final double totalAmount;
  final CommissionTypeEnum commissionType;
  final StatusEnum status;

  factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
    transactionUuid: json["transaction_uuid"],
    transactionType: json["transaction_type"],
    totalCommissionValue: json["total_commission_value"],
    amountSent: json["amount_sent"],
    amountCharacter: json["amount_character"],
    exchangeRate: json["exchange_rate"],
    transferFees: json["transfer_fees"],
    totalAmount: json["total_amount"].toDouble(),
    commissionType: CommissionTypeEnum.values.firstWhere(
      (e) => e.name == json['commission_type'],
    ),
    status: StatusEnum.values.firstWhere((e) => e.name == json['status']),
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
  ),
);

BranchModel dummyBranchModel = BranchModel(
  id: 1,
  name: 'فرع زلتين',
  transferFee: 0,
  commissionRatePercentage: '10',
);
