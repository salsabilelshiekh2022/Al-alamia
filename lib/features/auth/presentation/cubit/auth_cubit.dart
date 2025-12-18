import 'package:alalamia/core/di/dependency_injection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/database/cache/cache_services.dart';
import '../../../../core/enums/request_status.dart';
import '../../data/models/login_request_params.dart';
import '../../data/models/user_model.dart';
import '../../data/repos/auth_repo.dart';

part 'auth_state.dart';

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
          errorMessage: failure.message,
        ),
      ),
      (userModel) async {
        await getIt<CacheServices>().storeData<UserModel>(
          boxName: CacheBoxes.userModelBox,
          key: 'user',
          data: userModel,
        );

        emit(state.copyWith(authStatus: RequestStatus.success));
      },
    );
  }
}
