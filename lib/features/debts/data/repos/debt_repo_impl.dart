import 'package:alalamia/core/database/network/api_consumer.dart';
import 'package:alalamia/core/database/network/failure.dart';

import 'package:alalamia/features/debts/data/models/add_debt_request_params.dart';
import 'package:alalamia/features/debts/data/models/debt_model.dart';
import 'package:alalamia/features/debts/data/models/get_debts_by_currency_request_params.dart';
import 'package:alalamia/features/debts/data/models/pay_debt_request_params.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/network/end_points.dart';
import 'debt_repo.dart';

@LazySingleton(as: DebtRepo)
class DebtRepoImpl extends DebtRepo {
  final ApiConsumer apiConsumer;

  DebtRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, String>> addDebt({
    required AddDebtRequestParams addDebtRequestParams,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.addDebt,
        data: addDebtRequestParams.toJson(),
      ),
      onSuccess: (result) {
        return result['message'] ?? 'تمت العملية بنجاح';
      },
    );
  }

  @override
  Future<Either<Failure, String>> payDebt({
    required PayDebtRequestParams payDebtRequestParams,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.payDebt,
        data: payDebtRequestParams.toJson(),
      ),
      onSuccess: (result) {
        return result['message'] ?? 'تمت العملية بنجاح';
      },
    );
  }

  @override
  Future<Either<Failure, int>> getDebtsByCurrency({required int id, required GetDebtsByCurrencyRequestParams params}) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(
        EndPoints.getDebtsByCurrency(id: id),
        queryParameters: params.toJson(),
      ),
      onSuccess: (result) {
        return result['data']['total_debt'] ?? '0';
      },
    );
  }

  @override
  Future<Either<Failure, DebtsResponseModel>> getDebtsTransactions({required String type, int page = 1}) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(
        EndPoints.getDebtsTransactions(type: type),
        queryParameters: {'page': page},
      ),
      onSuccess: (result) {
        return DebtsResponseModel.fromJson(result);
      },
    );
  }
}
