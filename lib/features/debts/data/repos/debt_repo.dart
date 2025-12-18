import 'package:alalamia/features/debts/data/models/add_debt_request_params.dart';
import 'package:alalamia/features/debts/data/models/get_debts_by_currency_request_params.dart';
import 'package:alalamia/features/debts/data/models/pay_debt_request_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';
import '../models/debt_model.dart';

abstract class DebtRepo {
  Future<Either<Failure, String>> addDebt({
    required AddDebtRequestParams addDebtRequestParams,
  });
  Future<Either<Failure, String>> payDebt({
    required PayDebtRequestParams payDebtRequestParams,
  });
  Future<Either<Failure, int>> getDebtsByCurrency({required int id, required GetDebtsByCurrencyRequestParams params});
  Future<Either<Failure, List<DebtModel>>> getDebtsTransactions({required String type});
} 
