class CurrencyModel {
  final int? id;
  final String? currencyName;
  final String? currencyImage;
  final String? currencyCode;
  final String? balance;

  CurrencyModel({
    this.id,
    this.currencyName,
    this.currencyImage,
    this.currencyCode,
    this.balance,
  });


  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
    id: json["id"],
    currencyName: json["currency_name"],
    currencyImage: json["currency_image"],
    currencyCode: json["currency_code"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "currency_name": currencyName,
    "currency_image": currencyImage,
    "currency_code": currencyCode,
    "balance": balance,
  };
}