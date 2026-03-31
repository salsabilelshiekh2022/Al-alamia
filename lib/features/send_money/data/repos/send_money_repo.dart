import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';
import '../models/send_money_request_params.dart';

abstract class SendMoneyRepo {
  Future<Either<Failure, String>> sendMoney({
    required SendMoneyRequestParams params,
  });

  Future<Either<Failure, String>> updateTransaction({
    required int transactionId,
    required SendMoneyRequestParams params,
  });
}
