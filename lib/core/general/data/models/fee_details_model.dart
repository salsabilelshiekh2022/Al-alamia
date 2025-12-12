// {
//     "status": true,
//     "data": {
//         "amount": "1",
//         "from_currency": "الدينار الليبي",
//         "to_currency": "الدولار الأمريكي",
//         "converted_fee": "0",
//         "exchange_price": 0.0305,
//         "commission_rate": "2.50",
//         "commission_type": "none",
//         "commission_amount": 0,
//         "converted_amount": 0.0305,
//         "final_amount": 0.0305
//     },
//     "success": true
// }

import 'package:alalamia/core/enums/commission_type_enum.dart';

class FeeDetailsModel {
  final String? amount;
  final String? fromCurrency;
  final String? toCurrency;
  final String? convertedFee;
  final double? exchangePrice;
  final String? commissionRate;
  final CommissionTypeEnum? commissionType;
  final double? commissionAmount;
  final double? convertedAmount;
  final double? finalAmount;

  FeeDetailsModel({
    this.amount,
    this.fromCurrency,
    this.toCurrency,
    this.convertedFee,
    this.exchangePrice,
    this.commissionRate,
    this.commissionType,
    this.commissionAmount,
    this.convertedAmount,
    this.finalAmount,
  });

  factory FeeDetailsModel.fromJson(Map<String, dynamic> json) {
    return FeeDetailsModel(
      amount: json['amount'],
      fromCurrency: json['from_currency'],
      toCurrency: json['to_currency'],
      convertedFee: json['converted_fee'],
      exchangePrice: json['exchange_price'],
      commissionRate: json['commission_rate'],
      commissionType: CommissionTypeEnum.values.byName(json['commission_type']),
      commissionAmount: json['commission_amount'],
      convertedAmount: json['converted_amount'],
      finalAmount: json['final_amount'],
    );
  }
}
