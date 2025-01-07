import 'dart:convert';

BeanAccountList beanAccountListFromJson(String str) =>
    BeanAccountList.fromJson(json.decode(str));

String beanAccountListToJson(BeanAccountList data) =>
    json.encode(data.toJson());

class BeanAccountList {
  int userId;
  String nickname;
  String phone;
  String email;
  int authenticationStatus;
  int status;

  BeanAccountList({
    required this.userId,
    required this.nickname,
    required this.phone,
    required this.email,
    required this.authenticationStatus,
    required this.status,
  });

  factory BeanAccountList.fromJson(Map<String, dynamic> json) =>
      BeanAccountList(
        userId: json["userId"],
        nickname: json["nickname"],
        phone: json["phone"],
        email: json["email"],
        authenticationStatus: json["authenticationStatus"] ?? 1,
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "nickname": nickname,
        "phone": phone,
        "email": email,
        "authenticationStatus": authenticationStatus,
        "status": status,
      };
}
