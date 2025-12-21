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

  SendMoneyRequestParams({
    required this.senderPhone,
    required this.senderName,
    required this.fromCurrencyId,
    required this.toCurrencyId,
    required this.amount,
    required this.totalPrice,
    required this.amountByChar,
    required this.denominations,
    required this.note,
    required this.senderAddress,
    required this.receiverPhone,
    required this.receiverName,
    required this.receiverAddress,
    required this.fromBranchId,
    required this.toBranchId,
    required this.commissionType,
    required this.commissionAmount,
    required this.paymentMethodId,
    required this.receiverPhone2,
  });

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = <String, dynamic>{};
     data['sender_phone'] = senderPhone;
     data['sender_name'] = senderName;
     data['from_currency_id'] = fromCurrencyId;
     data['to_currency_id'] = toCurrencyId;
     data['amount'] = amount;
     data['total_price'] = totalPrice;
     data['amount_by_char'] = amountByChar;
     data['denominations'] = denominations.map((v) => v.toJson()).toList();
     data['note'] = note;
     data['sender_address'] = senderAddress;
     data['receiver_phone'] = receiverPhone;
     data['receiver_name'] = receiverName;
     data['receiver_address'] = receiverAddress;
     data['from_branch_id'] = fromBranchId;
     data['to_branch_id'] = toBranchId;
     data['commission_type'] = commissionType.toString();
     data['commission_amount'] = commissionAmount;
     data['payment_method_id'] = paymentMethodId;
     data['receiver_phone2'] = receiverPhone2;
     return data;
   }
}
