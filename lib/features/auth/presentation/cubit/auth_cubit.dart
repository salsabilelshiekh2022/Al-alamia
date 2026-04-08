import 'package:alalamia/core/di/dependency_injection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/cache/app_cache_helper.dart';
import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/database/cache/cache_services.dart';
import '../../../../core/enums/request_status.dart';
import '../../data/models/change_pass_request_model.dart' show ChangePassRequestModel;
import '../../data/models/login_request_params.dart';
import '../../data/models/reset_pass_request_params.dart';
import '../../data/models/send_code_request_params.dart';
import '../../data/models/user_model.dart';
import '../../data/models/verify_code_request_params.dart';
import '../../data/repos/auth_repo.dart';

part 'auth_state.dart';
@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepo authRepo})
    : _repo = authRepo,
      super(const AuthState());
  final AuthRepo _repo;

  Future<void> login({required LoginRequestParams loginRequestParams}) async {
    emit(state.copyWith(authStatus: RequestStatus.loading));
    final result = await _repo.login(loginRequestParams: loginRequestParams);
    result.fold(
      (failure) => emit(
        state.copyWith(
          authStatus: RequestStatus.error,
         message: failure.message,
        ),
      ),
      (userModel) async {
        await getIt<CacheServices>().storeData<UserModel>(
          boxName: CacheBoxes.userModelBox,
          key: 'user',
          data: userModel,
        );
         AppCacheHelper().saveValue(
          CacheKeys.token,
          userModel.token!,
        );

        emit(state.copyWith(authStatus: RequestStatus.success));
      },
    );
  }

  Future<void> changePassword ({required ChangePassRequestModel changePassRequestModel}) async {
    emit(state.copyWith(authStatus: RequestStatus.loading));
    final result = await _repo.changePassword(changePassRequestModel: changePassRequestModel);
    result.fold(
      (failure) => emit(state.copyWith(authStatus: RequestStatus.error, message: failure.message)),
      (message) => emit(state.copyWith(authStatus: RequestStatus.success , message: message)),
    );
  }

  Future<void> resetPassword ({required ResetPassRequestParams resetPassRequestParams}) async {
    emit(state.copyWith(authStatus: RequestStatus.loading));
    final result = await _repo.resetPassword(resetPassRequestParams: resetPassRequestParams);
    result.fold(
      (failure) => emit(state.copyWith(authStatus: RequestStatus.error, message: failure.message)),
      (message) => emit(state.copyWith(authStatus: RequestStatus.success , message: message)),
    );
  }

  Future<void> sendCodeOtp ({required SendCodeRequestParams sendCodeRequestParams}) async {
    emit(state.copyWith(authStatus: RequestStatus.loading));
    final result = await _repo.sendCodeOtp(sendCodeRequestParams: sendCodeRequestParams);
    result.fold(
      (failure) => emit(state.copyWith(authStatus: RequestStatus.error, message: failure.message)),
      (message) => emit(state.copyWith(authStatus: RequestStatus.success , message: message)),
    );
  }

  Future<void> verifyCodeOtp ({required VerifyCodeRequestParams verifyCodeRequestParams}) async {
    emit(state.copyWith(authStatus: RequestStatus.loading));
    final result = await _repo.verifyCodeOtp(verifyCodeRequestParams: verifyCodeRequestParams);
    result.fold(
      (failure) => emit(state.copyWith(authStatus: RequestStatus.error, message: failure.message)),
      (message) => emit(state.copyWith(authStatus: RequestStatus.success , message: message)),
    );
  }
}
