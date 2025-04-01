import 'dart:convert';

BeanNoteBack beanNoteBackFromJson(String str) =>
    BeanNoteBack.fromJson(json.decode(str));

String beanNoteBackToJson(BeanNoteBack data) => json.encode(data.toJson());

class BeanNoteBack {
  BigInt noteId;
  String title;
  String cover;
  int noteType;
  int createBy;
  String createNickname;
  String createTime;
  int auditedStatus;
  int? recommendedStatus;
  String sysUserNickname;

  BeanNoteBack({
    required this.noteId,
    required this.title,
    required this.cover,
    required this.noteType,
    required this.createBy,
    required this.createNickname,
    required this.createTime,
    required this.auditedStatus,
    required this.recommendedStatus,
    required this.sysUserNickname,
  });

  factory BeanNoteBack.fromJson(Map<String, dynamic> json) => BeanNoteBack(
        noteId: json["noteId"],
        title: json["title"],
        cover: json["cover"],
        noteType: json["noteType"],
        createBy: json["createBy"],
        createNickname: json["createNickname"],
        createTime: json["createTime"],
        auditedStatus: json["auditedStatus"],
        recommendedStatus: json["recommendedStatus"],
        sysUserNickname: json["sysUserNickname"],
      );

  Map<String, dynamic> toJson() => {
        "noteId": noteId,
        "title": title,
        "cover": cover,
        "noteType": noteType,
        "createBy": createBy,
        "createNickname": createNickname,
        "createTime": createTime,
        "auditedStatus": auditedStatus,
        "recommendedStatus": recommendedStatus,
        "sysUserNickname": sysUserNickname,
      };
}
