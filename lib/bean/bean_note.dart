import 'dart:convert';

BeanNote beanNoteFromJson(String str) => BeanNote.fromJson(json.decode(str));

String beanNoteToJson(BeanNote data) => json.encode(data.toJson());

class BeanNote {
  BigInt noteId;
  String title;
  String cover;
  int noteType;
  int status;
  int createBy;
  String createNickname;
  String createTime;
  int tendency;
  int auditedStatus;
  int? recommendedStatus;
  int auditedBy;
  String auditedNickname;

  BeanNote({
    BigInt? id,
    this.title = "",
    this.cover = "",
    this.noteType = 1,
    this.status = 1,
    this.createBy = 0,
    this.createNickname = "",
    this.createTime = "",
    this.tendency = 3,
    this.auditedStatus = 0,
    this.recommendedStatus = null,
    this.auditedBy = 0,
    this.auditedNickname = "",
  }) : noteId = id ?? BigInt.zero;

  factory BeanNote.fromJson(Map<String, dynamic> json) => BeanNote(
        id: json["noteId"],
        title: json["title"],
        cover: json["cover"],
        noteType: json["noteType"],
        status: json["status"],
        createBy: json["createBy"],
        createNickname: json["createNickname"],
        createTime: json["createTime"],
        tendency: json["tendency"],
        auditedStatus: json["auditedStatus"],
        recommendedStatus: json["recommendedStatus"],
        auditedBy: json["auditedBy"] ?? 0,
        auditedNickname: json["auditedNickname"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "noteId": noteId,
        "title": title,
        "cover": cover,
        "noteType": noteType,
        "status": status,
        "createBy": createBy,
        "createNickname": createNickname,
        "createTime": createTime,
        "tendency": tendency,
        "auditedStatus": auditedStatus,
        "recommendedStatus": recommendedStatus,
        "auditedBy": auditedBy,
        "auditedNickname": auditedNickname,
      };
}
