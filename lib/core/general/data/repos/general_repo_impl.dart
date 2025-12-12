import 'package:alalamia/core/database/network/api_consumer.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../database/network/end_points.dart';
import '../../../database/network/failure.dart';
import '../models/user_by_phone_model.dart';
import 'general_repo.dart';

@LazySingleton(as: GeneralRepo)
class GeneralRepoImpl extends GeneralRepo {
  final ApiConsumer apiConsumer;

  GeneralRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, UserByPhoneModel>> getUserByPhone({
    required String phone,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.getUserByPhone(phone: phone)),
      onSuccess: (result) {
        return UserByPhoneModel.fromJson(result['data']);
      },
    );
  }
}
