import '../../../transfer_money/data/models/transfer_money_request_params.dart';

class InAndOutRequestParams {
  final int currencyId;
  final double amount;
  final String notes;
  final List<DenominationsRequestParams> denominations;

  InAndOutRequestParams({
    required this.currencyId,
    required this.amount,
    required this.notes,
    required this.denominations,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency_id'] = currencyId;
    data['amount'] = amount;
    data['notes'] = notes;
    data['denominations'] = denominations.map((denom) => denom.toJson()).toList();
    return data;
  }

}