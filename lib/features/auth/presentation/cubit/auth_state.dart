part of 'auth_cubit.dart';


class AuthState extends Equatable {
  final RequestStatus authStatus;
  final String? errorMessage;

  const AuthState({
    this.authStatus = RequestStatus.initial,
    this.errorMessage,
  });

  AuthState copyWith({
    RequestStatus? authStatus,
    RequestStatus? signUpStatus,
    String? errorMessage,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    authStatus,
    errorMessage,
  ];
}