import 'dart:convert';

BeanNoteList beanNoteListFromJson(String str) =>
    BeanNoteList.fromJson(json.decode(str));

String beanNoteListToJson(BeanNoteList data) => json.encode(data.toJson());

class BeanNoteList {
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

  BeanNoteList({
    required this.noteId,
    required this.title,
    required this.cover,
    required this.noteType,
    required this.status,
    required this.createBy,
    required this.createNickname,
    required this.createTime,
    required this.tendency,
    required this.auditedStatus,
    required this.recommendedStatus,
    required this.auditedBy,
    required this.auditedNickname,
  });

  factory BeanNoteList.fromJson(Map<String, dynamic> json) => BeanNoteList(
        noteId: json["noteId"],
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
