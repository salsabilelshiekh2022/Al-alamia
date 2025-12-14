import 'package:alalamia/core/enums/commission_type_enum.dart';

import '../../../transfer_money/data/models/transfer_money_request_params.dart';

class SendMoneyRequestParams {
  final String senderPhone;
  final String senderName;
  final int fromCurrencyId;
  final int toCurrencyId;
  final double amount;
  final double totalPrice;
  final String amountByChar;
  final List<DenominationsRequestParams> denominations;
  final String note;
  final String? senderAddress;
  final String receiverPhone;
  final String receiverName;
  final String receiverAddress;
  final int fromBranchId;
  final int toBranchId;
  final CommissionTypeEnum commissionType;
  final num commissionAmount;
  final int paymentMethodId;
  final String? receiverPhone2;

  SendMoneyRequestParams({required this.senderPhone, required this.senderName, required this.fromCurrencyId, required this.toCurrencyId, required this.amount, required this.totalPrice, required this.amountByChar, required this.denominations, required this.note, required this.senderAddress, required this.receiverPhone, required this.receiverName, required this.receiverAddress, required this.fromBranchId, required this.toBranchId, required this.commissionType, required this.commissionAmount, required this.paymentMethodId, required this.receiverPhone2}); 
}