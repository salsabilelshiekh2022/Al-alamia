import 'package:alalamia/core/database/network/api_consumer.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/network/end_points.dart';
import '../../../../core/database/network/failure.dart';
import '../models/send_money_request_params.dart';
import 'send_money_repo.dart';

@LazySingleton(as: SendMoneyRepo)
class SendMoneyRepoImpl extends SendMoneyRepo {
  final ApiConsumer apiConsumer;

  SendMoneyRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, String>> sendMoney({
    required SendMoneyRequestParams params,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.sendMoney,
        data: params.toJson(),
        isFromData: true,
      ),
      onSuccess: (result) {
        return result['meta']['message'] ?? 'Success';
      },
    );
  }
}