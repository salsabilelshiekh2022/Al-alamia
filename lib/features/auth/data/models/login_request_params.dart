class LoginRequestParams {
  final String phone;
  final String password;

  LoginRequestParams({required this.phone, required this.password});

  factory LoginRequestParams.fromJson(Map<String, dynamic> json) {
    return LoginRequestParams(
      phone: json['phone'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {'phone': phone, 'password': password};
}

