import 'package:alalamia/generated/app_assets.dart';

class WalletModel {
  final int? id;
  final String? currencyName;
  final String? currencyImage;
  final String? currencyCode;
  final String? balance;

  WalletModel({
    this.id,
    this.currencyName,
    this.currencyImage,
    this.currencyCode,
    this.balance,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
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

WalletModel dummyCurrenyModel = WalletModel(
  id: 1,
  currencyName: 'Dollar ',
  currencyImage: "https://upload.wikimedia.org/wikipedia/en/a/a4/Flag_of_the_United_States.svg",
  currencyCode: 'USD',
  balance: '0.000',
);
