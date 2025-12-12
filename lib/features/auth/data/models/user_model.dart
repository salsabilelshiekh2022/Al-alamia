class UserModel {
  String? message;
  String? token;
  int? userId;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userSalary;
  String? userImage;
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

class Branch {
  int? id;
  String? name;

  Branch({required this.id, required this.name});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
