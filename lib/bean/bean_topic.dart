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
  BeanTopSearch? topSearch;

  BeanTopic({
    required this.id,
    required this.name,
    required this.avatar,
    required this.noteCnt,
    required this.status,
    required this.createTime,
    required this.topSearch,
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
            : BeanTopSearch.fromJson(json["topSearch"]),
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

class BeanTopSearch {
  int id;
  String name;

  BeanTopSearch({
    required this.id,
    required this.name,
  });

  factory BeanTopSearch.fromJson(Map<String, dynamic> json) => BeanTopSearch(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
