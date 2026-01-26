import 'package:alalamia/features/expenses/data/models/expense_model.dart';
import 'package:alalamia/features/expenses/data/models/expenses_request_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';

abstract class ExpensesRepo {
  Future<Either<Failure, String>> addExpense({
    required ExpensesRequestParams expensesRequestParams,
  });

  Future<Either<Failure, ExpensesResponseModel>> getExpenses({int page = 1});
  Future<Either<Failure, dynamic>> getExpensesByCurrency({required int id});
}
