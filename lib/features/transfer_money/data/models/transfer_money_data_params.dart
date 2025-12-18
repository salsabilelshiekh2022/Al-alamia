/// Data class to pass transfer money data between views.
/// Contains all required information from TransferMoneyView to pass to AddAmountByDenominationView.
class TransferMoneyDataParams {
  final String clientPhone;
  final String clientName;
  final int fromCurrencyId;
  final int toCurrencyId;
  final String amount;
  final String totalPrice;
  final String amountByChar;
  final String? note;

  const TransferMoneyDataParams({
    required this.clientPhone,
    required this.clientName,
    required this.fromCurrencyId,
    required this.toCurrencyId,
    required this.amount,
    required this.totalPrice,
    required this.amountByChar,
    this.note,
  });

  @override
  String toString() {
    return 'TransferMoneyDataParams(clientPhone: $clientPhone, clientName: $clientName, '
        'fromCurrencyId: $fromCurrencyId, toCurrencyId: $toCurrencyId, '
        'amount: $amount, totalPrice: $totalPrice, amountByChar: $amountByChar, note: $note)';
  }
}
