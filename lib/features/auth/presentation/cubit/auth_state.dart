part of 'auth_cubit.dart';


class AuthState extends Equatable {
  final RequestStatus authStatus;
  
  final String? message;

  const AuthState({
    this.authStatus = RequestStatus.initial,
    this.message,
  });

  AuthState copyWith({
    RequestStatus? authStatus,
    String?message,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
     message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    authStatus,
   message,
  ];
}