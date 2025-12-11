class TransferCurrencyRequestParams {
  final int fromCurrencyId;
  final int toCurrencyId;
  final num? amount;

  TransferCurrencyRequestParams({
    required this.fromCurrencyId,
    required this.toCurrencyId,
    this.amount,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from_currency_id'] = fromCurrencyId;
    data['to_currency_id'] = toCurrencyId;
    data['amount'] = amount;
    return data;
  }
}
