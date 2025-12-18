import 'package:alalamia/core/enums/debets_enum.dart';

class GetDebtsByCurrencyRequestParams {
  final DebetsTypeEnum? debtsType;
  final String? phone;

  GetDebtsByCurrencyRequestParams({this.debtsType, this.phone});

  Map<String, dynamic> toJson() => {'type': debtsType?.name, 'phone': phone};
}