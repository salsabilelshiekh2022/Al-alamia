import '../../../transfer_money/data/models/transfer_money_request_params.dart';

class ExpensesRequestParams {
  final String notes;
  final int currencyId;
  final String amount;
  final List <DenominationsRequestParams> denominations;

  ExpensesRequestParams({
    required this.notes,
    required this.currencyId,
    required this.amount,
    required this.denominations,
  });

  Map<String, dynamic> toJson() => {
    'notes': notes,
    'currency_id': currencyId,
    'amount': amount,
    'denominations': denominations,
  };

  @override
  String toString() =>
      'ExpensesRequestParams(notes: $notes, currencyId: $currencyId, amount: $amount denominations: $denominations)';
}
