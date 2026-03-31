import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/network/api_consumer.dart';
import '../../../../core/database/network/end_points.dart';
import '../../../../core/database/network/failure.dart';
import '../models/transfer_money_request_params.dart';
import 'transfer_money_repo.dart';

@LazySingleton(as: TransferMoneyRepo)
class TransferMoneyRepoImpl extends TransferMoneyRepo {
  final ApiConsumer apiConsumer;

  TransferMoneyRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, String>> transferMoney({
    required TransferMoneyRequestParams transferMoneyRequestParams,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.transferMoney,
        data: transferMoneyRequestParams.toJson(),
      ),
      onSuccess: (result) {
        return result['meta']['message'] ?? 'Success';
      },
    );
  }

  @override
  Future<Either<Failure, String>> updateTransaction({
    required int transactionId,
    required TransferMoneyRequestParams transferMoneyRequestParams,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.updateTransaction(transactionId: transactionId),
        data: transferMoneyRequestParams.toJson(),
      ),
      onSuccess: (result) {
        return result['meta']['message'] ?? 'Success';
      },
    );
  }
}
