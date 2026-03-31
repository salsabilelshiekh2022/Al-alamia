/// Data class to pass transfer money data between views.
/// Contains all required information from TransferMoneyView to pass to AddAmountByDenominationView.
class TransferMoneyDataParams {
  final String clientPhone;
  final String whatsappNumber;
  final String clientName;
  final int fromCurrencyId;
  final int toCurrencyId;
  final String amount;
  final String totalPrice;
  final String amountByChar;
  final String? note;
  final String? sendingMessageType;
  final int? transactionId;

  const TransferMoneyDataParams({
    required this.clientPhone,
    required this.whatsappNumber,
    required this.clientName,
    required this.fromCurrencyId,
    required this.toCurrencyId,
    required this.amount,
    required this.totalPrice,
    required this.amountByChar,
    this.note,
    this.sendingMessageType,
    this.transactionId,
  });

  TransferMoneyDataParams copyWith({
    String? clientPhone,
    String? whatsappNumber,
    String? clientName,
    int? fromCurrencyId,
    int? toCurrencyId,
    String? amount,
    String? totalPrice,
    String? amountByChar,
    String? note,
    String? sendingMessageType,
    int? transactionId,
  }) {
    return TransferMoneyDataParams(
      clientPhone: clientPhone ?? this.clientPhone,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      clientName: clientName ?? this.clientName,
      fromCurrencyId: fromCurrencyId ?? this.fromCurrencyId,
      toCurrencyId: toCurrencyId ?? this.toCurrencyId,
      amount: amount ?? this.amount,
      totalPrice: totalPrice ?? this.totalPrice,
      amountByChar: amountByChar ?? this.amountByChar,
      note: note ?? this.note,
      sendingMessageType: sendingMessageType ?? this.sendingMessageType,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  @override
  String toString() {
    return 'TransferMoneyDataParams(clientPhone: $clientPhone, whatsappNumber: $whatsappNumber, clientName: $clientName, '
        'fromCurrencyId: $fromCurrencyId, toCurrencyId: $toCurrencyId, '
        'amount: $amount, totalPrice: $totalPrice, amountByChar: $amountByChar, note: $note, '
        'sendingMessageType: $sendingMessageType, transactionId: $transactionId)';
  }
}
