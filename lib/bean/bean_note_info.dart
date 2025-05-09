import 'dart:convert';

BeanNoteInfo beanNoteInfoFromJson(String str) =>
    BeanNoteInfo.fromJson(json.decode(str));

String beanNoteInfoToJson(BeanNoteInfo data) => json.encode(data.toJson());

class BeanNoteInfo {
  BigInt noteId;
  int noteType;
  String title;
  String textContent;
  String cover;
  List<BeanNoteMaterial> materialList;
  int status;
  int auditedStatus;
  int? recommendedStatus;
  int tendency;
  int? auditedBy;
  String auditedNickname;
  int createBy;
  String createByNickname;
  String createTime;
  String topicList;
  String extra;
  bool isOwner;
  int? classifyId;

  BeanNoteInfo(
      {BigInt? id,
      this.noteType = 1,
      this.title = "",
      this.textContent = "",
      this.cover = "",
      this.materialList = const [],
      this.status = 1,
      this.auditedStatus = 0,
      this.recommendedStatus = null,
      this.tendency = 3,
      this.auditedBy = 0,
      this.auditedNickname = "",
      this.createBy = 0,
      this.createByNickname = "",
      this.createTime = "",
      this.topicList = "",
      this.extra = "",
      this.isOwner = false,
      this.classifyId = null})
      : noteId = id ?? BigInt.zero;

  factory BeanNoteInfo.fromJson(Map<String, dynamic> json) => BeanNoteInfo(
        id: json["noteId"],
        noteType: json["noteType"],
        title: json["title"],
        textContent: json["textContent"],
        cover: json["cover"],
        materialList: List<BeanNoteMaterial>.from(
            json["materialList"].map((x) => BeanNoteMaterial.fromJson(x))),
        status: json["status"],
        auditedStatus: json["auditedStatus"] ?? 0,
        recommendedStatus: json["recommendedStatus"],
        tendency: json["tendency"],
        auditedBy: json["auditedBy"],
        auditedNickname: json["auditedNickname"] ?? "",
        createBy: json["createBy"],
        createByNickname: json["createByNickname"] ?? "",
        createTime: json["createTime"],
        topicList: json["topicList"],
        extra: json["extra"] ?? "",
        isOwner: json["isOwner"] ?? false,
        classifyId: json["classifyId"],
      );

  Map<String, dynamic> toJson() => {
        "noteId": noteId,
        "noteType": noteType,
        "title": title,
        "textContent": textContent,
        "cover": cover,
        "materialList": List<dynamic>.from(materialList.map((x) => x.toJson())),
        "status": status,
        "auditedStatus": auditedStatus,
        "recommendedStatus": recommendedStatus,
        "tendency": tendency,
        "auditedBy": auditedBy,
        "auditedNickname": auditedNickname,
        "createBy": createBy,
        "createByNickname": createByNickname,
        "createTime": createTime,
        "topicList": topicList,
        "extra": extra,
        "isOwner": isOwner,
        "classifyId": classifyId,
      };
}

class BeanNoteMaterial {
  BigInt noteId;
  String thumb;
  String url;
  int type;
  int orderId;

  BeanNoteMaterial({
    required this.noteId,
    required this.thumb,
    required this.url,
    required this.type,
    required this.orderId,
  });

  factory BeanNoteMaterial.fromJson(Map<String, dynamic> json) =>
      BeanNoteMaterial(
        noteId: json["noteId"],
        thumb: json["thumb"],
        url: json["url"],
        type: json["type"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toJson() => {
        "noteId": noteId,
        "thumb": thumb,
        "url": url,
        "type": type,
        "orderId": orderId,
      };
}
