import 'dart:convert';

BeanUser beanUserFromJson(String str) => BeanUser.fromJson(json.decode(str));

String beanUserToJson(BeanUser data) => json.encode(data.toJson());

class BeanUser {
  int userId;
  String nickname;
  String avatar;
  int roleId;
  String token;
  List<int> resourceList;

  BeanUser({
    this.userId = 0,
    this.nickname = "",
    this.avatar = "",
    this.roleId = 2,
    this.token = "",
    this.resourceList = const [],
  });

  factory BeanUser.fromJson(Map<String, dynamic> json) => BeanUser(
        userId: json["userId"],
        nickname: json["nickname"],
        avatar: json["avatar"] ?? "",
        roleId: json["roleId"],
        token: json["token"],
        resourceList: List<int>.from(json["resourceList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "nickname": nickname,
        "avatar": avatar,
        "roleId": roleId,
        "token": token,
        "resourceList": List<dynamic>.from(resourceList.map((x) => x)),
      };
}
