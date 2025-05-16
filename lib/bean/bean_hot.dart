import 'dart:convert';

BeanHot beanHotFromJson(String str) => BeanHot.fromJson(json.decode(str));

String beanHotToJson(BeanHot data) => json.encode(data.toJson());

class BeanHot {
  int id;
  String title;
  int topicId;
  String topicName;
  int orderId;
  String createTime;
  int clickCnt;
  String introduction;

  BeanHot({
    this.id = 0,
    this.title = "",
    this.topicId = 0,
    this.topicName = "",
    this.orderId = 1,
    this.createTime = "",
    this.clickCnt = 0,
    this.introduction = "",
  });

  factory BeanHot.fromJson(Map<String, dynamic> json) => BeanHot(
        id: json["id"],
        title: json["title"],
        topicId: json["topicId"],
        topicName: json["topicName"],
        orderId: json["orderId"],
        createTime: json["createTime"],
        clickCnt: json["clickCnt"] ?? 0,
        introduction: json["introduction"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "topicId": topicId,
        "topicName": topicName,
        "orderId": orderId,
        "createTime": createTime,
        "clickCnt": clickCnt,
        "introduction": introduction,
      };
}
