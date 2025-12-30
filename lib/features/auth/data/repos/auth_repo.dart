import 'package:alalamia/features/auth/data/models/change_pass_request_model.dart';
import 'package:alalamia/features/auth/data/models/login_request_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';
import '../models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login({required LoginRequestParams loginRequestParams});
  Future<Either<Failure, String>> changePassword({required ChangePassRequestModel changePassRequestModel});
}