class ResetPassRequestParams {
  final String phone;
  final String password;
  final String passwordConfirmation;

  ResetPassRequestParams({required this.phone, required this.password, required this.passwordConfirmation});

  Map<String, dynamic> toJson() => {'phone': phone, 'password': password, 'password_confirmation': passwordConfirmation};

}