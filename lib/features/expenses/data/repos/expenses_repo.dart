import 'package:alalamia/features/expenses/data/models/expenses_request_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';

abstract class ExpensesRepo {
  Future<Either<Failure, String>> addExpense({
    required ExpensesRequestParams expensesRequestParams,
  });
}
