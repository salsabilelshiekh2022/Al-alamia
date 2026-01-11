class VerifyCodeRequestParams {
  final String phone;
  final String code;

  VerifyCodeRequestParams({required this.phone, required this.code});

  Map<String, dynamic> toJson() => {'phone': phone, 'otp': code};
}