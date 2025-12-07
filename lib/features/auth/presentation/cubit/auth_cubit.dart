import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/login_request_params.dart';
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
      (message) => emit(state.copyWith(authStatus: RequestStatus.success)),
    );
  }
}
