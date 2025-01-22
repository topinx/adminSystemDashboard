import 'dart:convert';

BeanHotSearch beanHotSearchFromJson(String str) =>
    BeanHotSearch.fromJson(json.decode(str));

String beanHotSearchToJson(BeanHotSearch data) => json.encode(data.toJson());

class BeanHotSearch {
  int id;
  String title;
  int topicId;
  String topicName;
  int orderId;
  String createTime;
  int clickCnt;

  BeanHotSearch({
    required this.id,
    required this.title,
    required this.topicId,
    required this.topicName,
    required this.orderId,
    required this.createTime,
    required this.clickCnt,
  });

  factory BeanHotSearch.fromJson(Map<String, dynamic> json) => BeanHotSearch(
        id: json["id"],
        title: json["title"],
        topicId: json["topicId"],
        topicName: json["topicName"],
        orderId: json["orderId"],
        createTime: json["createTime"],
        clickCnt: json["clickCnt"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "topicId": topicId,
        "topicName": topicName,
        "orderId": orderId,
        "createTime": createTime,
        "clickCnt": clickCnt,
      };
}
