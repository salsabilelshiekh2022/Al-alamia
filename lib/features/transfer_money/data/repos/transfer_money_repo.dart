import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';
import '../models/transfer_money_request_params.dart';

abstract class TransferMoneyRepo {
  Future<Either<Failure, String>> transferMoney({
    required TransferMoneyRequestParams transferMoneyRequestParams,
  });

  Future<Either<Failure, String>> updateTransaction({
    required int transactionId,
    required TransferMoneyRequestParams transferMoneyRequestParams,
  });
}
