import 'dart:convert';

BeanAccountInfo beanAccountInfoFromJson(String str) =>
    BeanAccountInfo.fromJson(json.decode(str));

String beanAccountInfoToJson(BeanAccountInfo data) =>
    json.encode(data.toJson());

class BeanAccountInfo {
  int userId;
  String nickname;
  String avatar;
  int gender;
  String birthday;
  int createTime;
  String areaCode;
  String phone;
  String email;
  String area;
  String brief;
  String bgImg;
  int authenticationStatus;
  int status;

  BeanAccountInfo({
    this.userId = 0,
    this.nickname = "",
    this.avatar = "",
    this.gender = 0,
    this.birthday = "",
    this.createTime = 0,
    this.areaCode = "",
    this.phone = "",
    this.email = "",
    this.area = "",
    this.brief = "",
    this.bgImg = "",
    this.authenticationStatus = 1,
    this.status = 1,
  });

  factory BeanAccountInfo.fromJson(Map<String, dynamic> json) =>
      BeanAccountInfo(
        userId: json["userId"],
        nickname: json["nickname"],
        avatar: json["avatar"],
        gender: json["gender"],
        birthday: json["birthday"],
        createTime: json["createTime"],
        areaCode: json["areaCode"],
        phone: json["phone"],
        email: json["email"],
        area: json["area"],
        brief: json["brief"],
        bgImg: json["bgImg"],
        authenticationStatus: json["authenticationStatus"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "nickname": nickname,
        "avatar": avatar,
        "gender": gender,
        "birthday": birthday,
        "createTime": createTime,
        "areaCode": areaCode,
        "phone": phone,
        "email": email,
        "area": area,
        "brief": brief,
        "bgImg": bgImg,
        "authenticationStatus": authenticationStatus,
        "status": status,
      };
}
