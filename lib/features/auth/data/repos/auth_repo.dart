import 'package:alalamia/features/auth/data/models/change_pass_request_model.dart';
import 'package:alalamia/features/auth/data/models/login_request_params.dart';
import 'package:alalamia/features/auth/data/models/reset_pass_request_params.dart';
import 'package:alalamia/features/auth/data/models/send_code_request_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';
import '../models/user_model.dart';
import '../models/verify_code_request_params.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login({required LoginRequestParams loginRequestParams});
  Future<Either<Failure, String>> changePassword({required ChangePassRequestModel changePassRequestModel});
  Future<Either<Failure, String>> sendCodeOtp({required SendCodeRequestParams sendCodeRequestParams});
  Future<Either<Failure, String>> verifyCodeOtp({required VerifyCodeRequestParams verifyCodeRequestParams});
  Future<Either<Failure, String>> resetPassword({required ResetPassRequestParams resetPassRequestParams});
  Future<Either<Failure, UserModel>> getProfile();
}