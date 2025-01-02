import 'dart:convert';

BeanRegister beanRegisterFromJson(String str) =>
    BeanRegister.fromJson(json.decode(str));

String beanRegisterToJson(BeanRegister data) => json.encode(data.toJson());

class BeanRegister {
  int userId;
  String nickname;
  int roleId;
  String password;

  BeanRegister({
    required this.userId,
    required this.nickname,
    required this.roleId,
    required this.password,
  });

  factory BeanRegister.fromJson(Map<String, dynamic> json) => BeanRegister(
        userId: json["userId"],
        nickname: json["nickname"],
        roleId: json["roleId"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "nickname": nickname,
        "roleId": roleId,
        "password": password,
      };
}
