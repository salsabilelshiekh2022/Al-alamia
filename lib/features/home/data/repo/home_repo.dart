import 'package:alalamia/core/database/network/failure.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:alalamia/features/home/data/models/transfer_currency_model.dart';
import 'package:alalamia/features/home/data/models/transfer_currency_request_params.dart';
import 'package:alalamia/features/home/data/models/wallet_model.dart';
import 'package:alalamia/features/home/data/models/denominations_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<WalletModel>>> getBranchCurrencies();
  Future<Either<Failure, DenominationsResponseModel>> getDenominationsOfCurrency({
    required int currencyId,
  });

  Future<Either<Failure, List<CurrencyModel>>> getCurrencies();
  Future<Either<Failure, TransferCurrencyModel>> transferCurrency({
    required TransferCurrencyRequestParams transferCurrencyRequestParams,
  });
}
