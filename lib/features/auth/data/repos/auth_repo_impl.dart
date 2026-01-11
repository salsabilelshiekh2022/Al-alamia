import 'package:alalamia/core/database/network/failure.dart';
import 'package:alalamia/features/auth/data/models/login_request_params.dart';
import 'package:alalamia/features/auth/data/models/reset_pass_request_params.dart';
import 'package:alalamia/features/auth/data/models/send_code_request_params.dart';
import 'package:alalamia/features/auth/data/models/verify_code_request_params.dart';
import 'package:alalamia/features/auth/data/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/network/api_consumer.dart';
import '../../../../core/database/network/end_points.dart';
import '../models/change_pass_request_model.dart';
import '../models/user_model.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  final ApiConsumer apiConsumer;

  AuthRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, UserModel>> login({
    required LoginRequestParams loginRequestParams,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(path: EndPoints.login,
          data: loginRequestParams.toJson()),
      onSuccess: (result) {
        
        return UserModel.fromJson(result);
      },
    );
  }
  
  @override
  Future<Either<Failure, String>> changePassword({
    required ChangePassRequestModel changePassRequestModel,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.changePassword,
        data: changePassRequestModel.toJson(), 
      ),
      onSuccess: (result) {
        return result['message'] ?? 'Success';
      },
    );
  }

  @override
  Future<Either<Failure, String>> resetPassword({required ResetPassRequestParams resetPassRequestParams}) {
   
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.resetPassword,
        data: resetPassRequestParams.toJson(),
      ),
      onSuccess: (result) {
        return result['message'] ?? 'Success';
      },
    );
  }

  @override
  Future<Either<Failure, String>> sendCodeOtp({required SendCodeRequestParams sendCodeRequestParams}) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.sendOtp,
        data: sendCodeRequestParams.toJson(),
      ),
      onSuccess: (result) {
        return result['message'] ?? 'Success';
      },
    );
  }

  @override
  Future<Either<Failure, String>> verifyCodeOtp({required VerifyCodeRequestParams verifyCodeRequestParams}) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.verifyOtp,
        data: verifyCodeRequestParams.toJson(),
      ),
      onSuccess: (result) {
        return result['message'] ?? 'Success';
      },
    );
  }
}
