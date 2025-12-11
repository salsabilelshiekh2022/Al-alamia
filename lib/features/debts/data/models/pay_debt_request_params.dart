class PayDebtRequestParams {
  final String? notes;
  final int currencyId;
  final String amount;

  PayDebtRequestParams({
    this.notes,
    required this.currencyId,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
    'notes': notes,
    'currency_id': currencyId,
    'amount': amount,
  };

  @override
  String toString() =>
      'PayDebtRequestParams(notes: $notes, currencyId: $currencyId, amount: $amount)';
}
