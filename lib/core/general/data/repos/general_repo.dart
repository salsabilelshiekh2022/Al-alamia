import 'package:alalamia/core/general/data/models/fee_details_model.dart';
import 'package:dartz/dartz.dart';

import '../../../database/network/failure.dart';
import '../models/fee_details_request_params.dart';
import '../models/user_by_phone_model.dart';

abstract class GeneralRepo {
  Future<Either<Failure, UserByPhoneModel>> getUserByPhone({
    required String phone,
  });

  Future<Either<Failure, FeeDetailsModel>> getFeeDetails({
    required FeeDetailsRequestParams feeDetailsRequestParams,
  });
}
