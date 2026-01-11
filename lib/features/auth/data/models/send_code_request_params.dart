class SendCodeRequestParams {
  final String phone;
  SendCodeRequestParams({required this.phone});

  Map<String, dynamic> toJson() => {'phone': phone};
}