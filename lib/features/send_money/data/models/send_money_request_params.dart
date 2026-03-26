import 'package:alalamia/core/enums/commission_type_enum.dart';
import 'package:alalamia/core/enums/delivery_type_enum.dart';

import '../../../transfer_money/data/models/transfer_money_request_params.dart';

class SendMoneyRequestParams {
  final String senderPhone;
  final String senderWhatsApp;
  final String senderName;
  final int fromCurrencyId;
  final int toCurrencyId;
  final double amount;
  final String amountByChar;
  final List<DenominationsRequestParams> denominations;
  final String note;
  final String? senderAddress;
  final String receiverPhone;
  final String receiverWhatsApp;
  final String receiverName;
  final String? receiverAddress;
  final int fromBranchId;
  final int toBranchId;
  final CommissionTypeEnum commissionType;
  final int? paymentMethodId;
  final String? receiverPhone2;
  final DeliveryTypeEnum deliveryType;

  SendMoneyRequestParams({
    required this.senderPhone,
    required this.senderWhatsApp,
    required this.senderName,
    required this.fromCurrencyId,
    required this.toCurrencyId,
    required this.amount,
    required this.amountByChar,
    required this.denominations,
    required this.note,
    required this.senderAddress,
    required this.receiverPhone,
    required this.receiverWhatsApp,
    required this.receiverName,
    required this.receiverAddress,
    required this.fromBranchId,
    required this.toBranchId,
    required this.commissionType,
    this.paymentMethodId,
    required this.receiverPhone2,
    required this.deliveryType,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_phone'] = senderPhone;
    data['sender_whatsapp_number'] = senderWhatsApp;
    data['sender_name'] = senderName;
    data['from_currency_id'] = fromCurrencyId;

    // For inside delivery, to_currency_id should be same as from_currency_id
    // For outside delivery, use the actual toCurrencyId
    data['to_currency_id'] = deliveryType == DeliveryTypeEnum.inside
        ? fromCurrencyId
        : toCurrencyId;
    data['amount'] = amount;
    data['amount_by_char'] = amountByChar;
    data['denominations'] = denominations.map((v) => v.toJson()).toList();
    data['note'] = note;
    data['sender_address'] = senderAddress;
    data['reciever_phone'] = receiverPhone;
    data['receiver_whatsapp_number'] = receiverWhatsApp;
    data['reciever_name'] = receiverName;
    data['reciever_address'] = receiverAddress;
    data['from_branch_id'] = fromBranchId;
    data['to_branch_id'] = toBranchId;
    data['commission_type'] = commissionType.name;

    // Only include payment_method_id for outside delivery
    if (deliveryType == DeliveryTypeEnum.outside && paymentMethodId != null) {
      data['payment_method_id'] = paymentMethodId;
    }

    data['reciever_phone_2'] = receiverPhone2;

    // Send delivery type as receive_type to backend
    data['receive_type'] = deliveryType == DeliveryTypeEnum.inside
        ? 'inside'
        : 'outside';

    return data;
  }
}
