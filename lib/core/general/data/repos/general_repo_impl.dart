import 'package:alalamia/core/database/network/api_consumer.dart';
import 'package:alalamia/core/general/data/models/denomination_model.dart';
import 'package:alalamia/core/general/data/models/fee_details_model.dart';
import 'package:alalamia/core/general/data/models/fee_details_request_params.dart';
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

  @override
  Future<Either<Failure, FeeDetailsModel>> getFeeDetails({
    required FeeDetailsRequestParams feeDetailsRequestParams,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(
        EndPoints.getFeeDetails,
        queryParameters: feeDetailsRequestParams.toJson(),
      ),
      onSuccess: (result) {
        return FeeDetailsModel.fromJson(result['data']);
      },
    );
  }

  @override
  Future<Either<Failure, List<DenominationModel>>> getAllDenominations() {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.getAllDenominations),
      onSuccess: (result) {
        return List<DenominationModel>.from(
          result['data'].map((x) => DenominationModel.fromJson(x)),
        );
      },
    );
  }
}
