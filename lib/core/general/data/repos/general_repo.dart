import 'package:alalamia/core/general/data/models/branch_model.dart';
import 'package:alalamia/core/general/data/models/denomination_model.dart';
import 'package:alalamia/core/general/data/models/fee_details_model.dart';
import 'package:alalamia/core/general/data/models/payment_method_model.dart';
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

  Future<Either<Failure, List<DenominationModel>>> getAllDenominations();
  Future<Either<Failure, List<BranchModel>>> getAllBranches({
    Map<String, dynamic>? queryParameters,
  });
  Future<Either<Failure, List<PaymentMethodModel>>> getPaymentMethods({
    required int branchId,
  });
}
