import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String? message;

  String? token;
  @HiveField(1)
  int? userId;
  @HiveField(2)
  String? userName;
  @HiveField(3)
  String? userEmail;
  @HiveField(4)
  String? userPhone;
  @HiveField(5)
  String? userSalary;
  @HiveField(6)
  String? userImage;
  @HiveField(7)
  Branch? branch;
  @HiveField(9)
  String? rewarded;
  @HiveField(10)
  String? penalized;
  @HiveField(11)
  String? currency;

  UserModel({
    required this.message,
    required this.token,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userSalary,
    required this.userImage,
    required this.branch,
    required this.rewarded,
    required this.penalized,
    required this.currency,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    userId = json['user']['id'];
    userName = json['user']['name'];
    userEmail = json['user']['email'];
    userPhone = json['user']['phone'];
    userSalary = json['user']['salary'];
    userImage = json['user']['image'];
    branch = Branch.fromJson(json['branch']);
    rewarded = json['user']['rewarded'];
    penalized = json['user']['penalized'];
    currency = json['user']['currency'];
  }
}

@HiveType(typeId: 2)
class Branch {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  int? transferFee;
  @HiveField(3)
  String? commissionRatePercentage;
  @HiveField(4)
  int? commissionCanChange;
  @HiveField(5)
  int? noCommission;

  Branch({
    required this.id,
    required this.name,
    required this.transferFee,
    required this.commissionRatePercentage,
    required this.commissionCanChange,
    required this.noCommission,
  });

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    transferFee = json['transfer_fee'];
    commissionRatePercentage = json['commission_rate_percentage'];
    commissionCanChange = json['commission_can_change'];
    noCommission = json['no_commission'];
  }
}
