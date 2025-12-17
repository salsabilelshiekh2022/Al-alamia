class TransferMoneyRequestParams {
  final String clientPhone;
  final String clientName;
  final int fromCurrencyId;
  final int toCurrencyId;
  final String amount;
  final String totalPrice;
  final String amountByChar;
  final List<DenominationsRequestParams> denominations;
  final List<DenominationsRequestParams> denominationsOut ;
  final String? note;

  TransferMoneyRequestParams({
    required this.clientPhone,
    required this.clientName,
    required this.fromCurrencyId,
    required this.toCurrencyId,
    required this.amount,
    required this.totalPrice,
    required this.amountByChar,
    required this.denominations,
    required this.denominationsOut,
    this.note,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_phone'] = clientPhone;
    data['client_name'] = clientName;
    data['from_currency_id'] = fromCurrencyId;
    data['to_currency_id'] = toCurrencyId;
    data['amount'] = amount;
    data['total_price'] = totalPrice;
    data['amount_by_char'] = amountByChar;
    data['denominations'] = denominations.map((v) => v.toJson()).toList();
    data['denominations_out'] = denominationsOut.map((v) => v.toJson()).toList();
    data['note'] = note;
    return data;
  }
}

class DenominationsRequestParams {
  final int id;
  final int quantity;

  DenominationsRequestParams({required this.id, required this.quantity});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    return data;
  }

@override
  String toString() {
    return 'DenominationsRequestParams{id: $id, quantity: $quantity}';
  }


}
