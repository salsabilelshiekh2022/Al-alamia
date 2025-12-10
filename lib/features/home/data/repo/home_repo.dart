import 'package:alalamia/core/database/network/failure.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:alalamia/features/home/data/models/denominations_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CurrencyModel>>> getBranchCurrencies();
  Future<Either<Failure, List<DenominationsModel>>> getDenominationsOfCurrency({
    required int currencyId,
  });
}
