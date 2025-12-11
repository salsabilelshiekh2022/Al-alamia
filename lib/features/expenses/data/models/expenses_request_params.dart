class ExpensesRequestParams {
  final String notes;
  final int currencyId;
  final String amount;

  ExpensesRequestParams({
    required this.notes,
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
      'ExpensesRequestParams(notes: $notes, currencyId: $currencyId, amount: $amount)';
}
