// features/send_money/domain/models/send_money_form_data.dart
import 'package:alalamia/core/enums/commission_type_enum.dart';
import 'package:alalamia/core/enums/delivery_type_enum.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:equatable/equatable.dart';

import '../../../transfer_money/data/models/transfer_money_request_params.dart';
import 'send_money_request_params.dart';

class SendMoneyFormData extends Equatable {
  // Sender Information
  final String senderPhone;
  final String senderWhatsApp;
  final String senderName;
  final String? senderAddress;

  // Receiver Information
  final String receiverPhone;
  final String receiverWhatsApp;
  final String receiverName;
  final String? receiverAddress;
  final String? receiverPhone2;

  // Transaction Details
  final CurrencyModel? fromCurrency;
  final CurrencyModel? toCurrency;
  final int? fromBranch;
  final int? toBranch;
  final String amount;
  final String totalPrice;
  final String amountByChar;
  final List<Map<String, dynamic>> denominations;
  final String note;

  // Commission & Payment
  final CommissionTypeEnum? commissionType;
  final double commissionAmount;
  final int? paymentMethodId;

  // Delivery Type
  final DeliveryTypeEnum deliveryType;

  const SendMoneyFormData({
    // Sender Info
    this.senderPhone = '',
    this.senderWhatsApp = '',
    this.senderName = '',
    this.senderAddress,

    // Receiver Info
    this.receiverPhone = '',
    this.receiverWhatsApp = '',
    this.receiverName = '',
    this.receiverAddress = '',
    this.receiverPhone2,

    // Transaction
    this.fromCurrency,
    this.toCurrency,
    this.fromBranch,
    this.toBranch,
    this.amount = '',
    this.totalPrice = '',
    this.amountByChar = '',
    this.denominations = const [],
    this.note = '',

    // Commission & Payment
    this.commissionType,
    this.commissionAmount = 0.0,
    this.paymentMethodId,

    // Delivery Type
    this.deliveryType = DeliveryTypeEnum.inside,
  });

  factory SendMoneyFormData.empty() => const SendMoneyFormData();

  SendMoneyFormData copyWith({
    // Sender Info
    String? senderPhone,
    String? senderWhatsApp,
    String? senderName,
    String? senderAddress,

    // Receiver Info
    String? receiverPhone,
    String? receiverWhatsApp,
    String? receiverName,
    String? receiverAddress,
    String? receiverPhone2,

    // Transaction
    CurrencyModel? fromCurrency,
    CurrencyModel? toCurrency,
    int? fromBranch,
    int? toBranch,
    String? amount,

    String? amountByChar,
    List<Map<String, dynamic>>? denominations,
    String? note,
    // Commission & Payment
    CommissionTypeEnum? commissionType,
    int? paymentMethodId,

    // Delivery Type
    DeliveryTypeEnum? deliveryType,
  }) {
    return SendMoneyFormData(
      // Sender Info
      senderPhone: senderPhone ?? this.senderPhone,
      senderWhatsApp: senderWhatsApp ?? this.senderWhatsApp,
      senderName: senderName ?? this.senderName,
      senderAddress: senderAddress ?? this.senderAddress,

      // Receiver Info
      receiverPhone: receiverPhone ?? this.receiverPhone,
      receiverWhatsApp: receiverWhatsApp ?? this.receiverWhatsApp,
      receiverName: receiverName ?? this.receiverName,
      receiverAddress: receiverAddress ?? this.receiverAddress,
      receiverPhone2: receiverPhone2 ?? this.receiverPhone2,

      // Transaction
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      fromBranch: fromBranch ?? this.fromBranch,
      toBranch: toBranch ?? this.toBranch,
      amount: amount ?? this.amount,

      amountByChar: amountByChar ?? this.amountByChar,
      denominations: denominations ?? this.denominations,
      note: note ?? this.note,

      // Commission & Payment
      commissionType: commissionType ?? this.commissionType,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,

      // Delivery Type
      deliveryType: deliveryType ?? this.deliveryType,
    );
  }

  // Validation getters
  bool get hasSenderInfo =>
      senderPhone.isNotEmpty &&
      senderName.isNotEmpty &&
      senderWhatsApp.isNotEmpty;

  bool get hasReceiverInfo =>
      receiverPhone.isNotEmpty &&
      receiverName.isNotEmpty &&
      receiverWhatsApp.isNotEmpty;

  bool get hasAmountDetails =>
      amount.isNotEmpty &&
      amountByChar.isNotEmpty &&
      fromCurrency != null &&
      toCurrency != null;

  bool get hasBranches => fromBranch != null && toBranch != null;

  bool get hasCommissionDetails => commissionType != null;

  // Payment method is only required for outside delivery
  bool get hasPaymentMethod =>
      deliveryType == DeliveryTypeEnum.inside || paymentMethodId != null;

  bool get hasDenominations => denominations.isNotEmpty;

  bool get hasRequiredFields =>
      hasSenderInfo &&
      hasReceiverInfo &&
      hasAmountDetails &&
      hasBranches &&
      hasCommissionDetails &&
      hasPaymentMethod &&
      hasDenominations;

  // Convert to SendMoneyRequestParams
  SendMoneyRequestParams toRequestParams() {
    final denominationParams = denominations
        .map(
          (denom) => DenominationsRequestParams(
            id: denom['id'] as int,
            quantity: denom['quantity'] as int,
          ),
        )
        .toList();

    return SendMoneyRequestParams(
      senderPhone: senderPhone,
      senderWhatsApp: senderWhatsApp,
      senderName: senderName,
      senderAddress: senderAddress,
      fromCurrencyId: fromCurrency!.id!,
      toCurrencyId: toCurrency!.id!,
      amount: double.parse(amount),
      amountByChar: amountByChar,
      denominations: denominationParams,
      note: note,
      receiverPhone: receiverPhone,
      receiverWhatsApp: receiverWhatsApp,
      receiverName: receiverName,
      receiverAddress: receiverAddress,
      fromBranchId: fromBranch!,
      toBranchId: toBranch!,
      commissionType: commissionType!,
      paymentMethodId: paymentMethodId,
      receiverPhone2: receiverPhone2,
      deliveryType: deliveryType,
    );
  }

  @override
  List<Object?> get props => [
    senderPhone,
    senderWhatsApp,
    senderName,
    senderAddress,
    receiverPhone,
    receiverWhatsApp,
    receiverName,
    receiverAddress,
    receiverPhone2,
    fromCurrency,
    toCurrency,
    fromBranch,
    toBranch,
    amount,
    totalPrice,
    amountByChar,
    denominations,
    note,
    commissionType,
    commissionAmount,
    paymentMethodId,
    deliveryType,
  ];
}
