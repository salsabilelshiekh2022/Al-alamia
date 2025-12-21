class TransferCurrencyModel {
  final int? fromCurrencyId;
  final int? toCurrencyId;
  final num? exchangePriceUsed;
  final num? amount;
  final String? convertedAmount;

  TransferCurrencyModel({
    this.fromCurrencyId,
    this.toCurrencyId,
    this.exchangePriceUsed,
    this.amount,
    this.convertedAmount,
  });

  factory TransferCurrencyModel.fromJson(Map<String, dynamic> json) {
    return TransferCurrencyModel(
      fromCurrencyId: json['from_currency_id'],
      toCurrencyId: json['to_currency_id'],
      exchangePriceUsed: json['exchange_price_used'],
      amount: json['amount'],
      convertedAmount: json['converted_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from_currency_id'] = fromCurrencyId;
    data['to_currency_id'] = toCurrencyId;
    data['exchange_price_used'] = exchangePriceUsed;
    data['amount'] = amount;
    data['converted_amount'] = convertedAmount;
    return data;
  }
}
