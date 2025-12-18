class PayDebtRequestParams {
  final String? notes;
  final int currencyId;
  final String amount;
  final String? phone;
  final String? name;

  PayDebtRequestParams({
    this.notes,
    required this.currencyId,
    required this.amount,
    this.phone,
    this.name,
  });

  Map<String, dynamic> toJson() => {
    'notes': notes,
    'currency_id': currencyId,
    'amount': amount,
    'phone': phone,
    'name': name
  };

  @override
  String toString() =>
      'PayDebtRequestParams(notes: $notes, currencyId: $currencyId, amount: $amount, phone: $phone name: $name)';
}
