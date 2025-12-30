class ChangePassRequestModel {
  final String oldPassword;
  final String newPassword;
  final String passwordConfirmation;

  ChangePassRequestModel({
    required this.oldPassword,
    required this.newPassword,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'old_password': oldPassword,
      'password': newPassword,
      'password_confirmation': passwordConfirmation,
    };
  }
}