import 'dart:convert';

BeanTopic beanTopicFromJson(String str) => BeanTopic.fromJson(json.decode(str));

String beanTopicToJson(BeanTopic data) => json.encode(data.toJson());

class BeanTopic {
  int id;
  String name;
  String avatar;
  int noteCnt;
  int status;
  String createTime;
  BeanHotSearch? topSearch;

  BeanTopic({
    this.id = 0,
    this.name = "",
    this.avatar = "",
    this.noteCnt = 1,
    this.status = 0,
    this.createTime = "",
    this.topSearch = null,
  });

  factory BeanTopic.fromJson(Map<String, dynamic> json) => BeanTopic(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        noteCnt: json["noteCnt"],
        status: json["status"],
        createTime: json["createTime"],
        topSearch: json["topSearch"] == null
            ? null
            : BeanHotSearch.fromJson(json["topSearch"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "noteCnt": noteCnt,
        "status": status,
        "createTime": createTime,
        "topSearch": topSearch?.toJson(),
      };
}

class BeanHotSearch {
  int id;
  String name;

  BeanHotSearch({
    required this.id,
    required this.name,
  });

  factory BeanHotSearch.fromJson(Map<String, dynamic> json) => BeanHotSearch(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
