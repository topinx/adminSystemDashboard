import 'dart:convert';

BeanAccount beanAccountFromJson(String str) =>
    BeanAccount.fromJson(json.decode(str));

String beanAccountToJson(BeanAccount data) => json.encode(data.toJson());

class BeanAccount {
  int userId;
  String nickname;
  String phone;
  String email;
  int authenticationStatus;
  int status;

  BeanAccount({
    required this.userId,
    required this.nickname,
    required this.phone,
    required this.email,
    required this.authenticationStatus,
    required this.status,
  });

  factory BeanAccount.fromJson(Map<String, dynamic> json) => BeanAccount(
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
