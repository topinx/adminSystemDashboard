import 'dart:convert';

BeanSearchUser beanSearchUserFromJson(String str) =>
    BeanSearchUser.fromJson(json.decode(str));

String beanSearchUserToJson(BeanSearchUser data) => json.encode(data.toJson());

class BeanSearchUser {
  int userId;
  String nickname;

  BeanSearchUser({
    required this.userId,
    required this.nickname,
  });

  factory BeanSearchUser.fromJson(Map<String, dynamic> json) => BeanSearchUser(
        userId: json["userId"],
        nickname: json["nickname"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "nickname": nickname,
      };
}
