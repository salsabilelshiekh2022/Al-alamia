import 'package:alalamia/core/database/network/api_consumer.dart';
import 'package:alalamia/core/database/network/failure.dart';
import 'package:alalamia/features/expenses/data/models/expense_model.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/network/end_points.dart';
import '../models/expenses_request_params.dart';
import 'expenses_repo.dart';

@LazySingleton(as: ExpensesRepo)
class ExpensesRepoImpl extends ExpensesRepo {
  final ApiConsumer apiConsumer;
  ExpensesRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, String>> addExpense({
    required ExpensesRequestParams expensesRequestParams,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.addExpenses,
        data: expensesRequestParams.toJson(),
      ),
      onSuccess: (result) {
        return result['message'] ?? 'تمت العملية بنجاح';
      },
    );
  }

  @override
  Future<Either<Failure, List<ExpenseModel>>> getExpenses() {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.getExpenses),
      onSuccess: (result) {
        final data = result['data'] as List;
        return data.map((e) => ExpenseModel.fromJson(e)).toList();
      },
    );
  }
  
  @override
  Future<Either<Failure, String>> getExpensesByCurrency({required int id}) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.getExpensesByCurrency(id: id)),
      onSuccess: (result) {
        return result['data']['expenses_amount'] ?? '0';
      },
    );
  }
}
