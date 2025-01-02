import 'dart:convert';

BeanLogin beanLoginFromJson(String str) => BeanLogin.fromJson(json.decode(str));

String beanLoginToJson(BeanLogin data) => json.encode(data.toJson());

class BeanLogin {
  int userId;
  String nickname;
  String avatar;
  int roleId;
  String token;
  List<int> resourceList;

  BeanLogin.empty()
      : userId = 0,
        nickname = "",
        avatar = "",
        roleId = 2,
        token = "",
        resourceList = [];

  BeanLogin({
    required this.userId,
    required this.nickname,
    required this.avatar,
    required this.roleId,
    required this.token,
    required this.resourceList,
  });

  factory BeanLogin.fromJson(Map<String, dynamic> json) => BeanLogin(
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
