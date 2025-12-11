import 'package:alalamia/core/database/network/api_consumer.dart';
import 'package:alalamia/core/database/network/failure.dart';

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
        return result['message'] ?? 'Success';
      },
    );
  }
}
