import 'package:alalamia/features/transfer_money/data/models/transfer_money_request_params.dart';

class PayDebtRequestParams {
  final String? notes;
  final int currencyId;
  final String amount;
  final String? phone;
  final String? name;
  final List<DenominationsRequestParams>? denominations;

  PayDebtRequestParams({
    this.notes,
    required this.currencyId,
    required this.amount,
    this.phone,
    this.name,
    this.denominations
  });

  Map<String, dynamic> toJson() => {
    'notes': notes,
    'currency_id': currencyId,
    'amount': amount,
    'phone': phone,
    'name': name,
    'denominations': denominations
  };

  @override
  String toString() =>
      'PayDebtRequestParams(notes: $notes, currencyId: $currencyId, amount: $amount, phone: $phone name: $name, denominations: $denominations)';
}
