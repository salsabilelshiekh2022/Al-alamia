import 'package:alalamia/core/enums/commission_type_enum.dart';

class FeeDetailsRequestParams {
  final int fromCurrencyId;
  final int toCurrencyId;
  final String amount;
  final CommissionTypeEnum commissionType;

  FeeDetailsRequestParams({
    required this.fromCurrencyId,
    required this.toCurrencyId,
    required this.amount,
    this.commissionType = CommissionTypeEnum.none,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from_currency_id'] = fromCurrencyId;
    data['to_currency_id'] = toCurrencyId;
    data['amount'] = amount;
    data['commission_type'] = commissionType.name;
    return data;
  }
}
