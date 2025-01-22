import 'dart:convert';

BeanNoteDetail beanNoteDetailFromJson(String str) =>
    BeanNoteDetail.fromJson(json.decode(str));

String beanNoteDetailToJson(BeanNoteDetail data) => json.encode(data.toJson());

class BeanNoteDetail {
  int noteId;
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

  BeanNoteDetail({
    required this.noteId,
    required this.noteType,
    required this.title,
    required this.textContent,
    required this.cover,
    required this.materialList,
    required this.status,
    required this.auditedStatus,
    required this.recommendedStatus,
    required this.tendency,
    required this.auditedBy,
    required this.auditedNickname,
    required this.createBy,
    required this.createByNickname,
    required this.createTime,
    required this.topicList,
    required this.extra,
    required this.isOwner,
  });

  BeanNoteDetail.empty()
      : noteId = 0,
        noteType = 1,
        title = "",
        textContent = "",
        cover = "",
        materialList = [],
        status = 1,
        auditedStatus = 0,
        recommendedStatus = null,
        tendency = 3,
        auditedBy = 0,
        auditedNickname = "",
        createBy = 0,
        createByNickname = "",
        createTime = "",
        topicList = "",
        extra = "",
        isOwner = false;

  factory BeanNoteDetail.fromJson(Map<String, dynamic> json) => BeanNoteDetail(
        noteId: json["noteId"],
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
        createByNickname: json["createByNickname"],
        createTime: json["createTime"],
        topicList: json["topicList"],
        extra: json["extra"],
        isOwner: json["isOwner"],
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
      };
}

class BeanNoteMaterial {
  int noteId;
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
