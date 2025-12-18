import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';
@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String? message;
  @HiveField(8)
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
  }
}

@HiveType(typeId: 2)
class Branch {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  Branch({required this.id, required this.name});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
