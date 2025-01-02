import 'dart:convert';

BeanMenu beanMenuFromJson(String str) => BeanMenu.fromJson(json.decode(str));

String beanMenuToJson(BeanMenu data) => json.encode(data.toJson());

class BeanMenu {
  int resourceId;
  int parentId;
  String resourceName;

  BeanMenu({
    required this.resourceId,
    required this.parentId,
    required this.resourceName,
  });

  factory BeanMenu.fromJson(Map<String, dynamic> json) => BeanMenu(
        resourceId: json["resourceId"],
        parentId: json["parentId"],
        resourceName: json["resourceName"],
      );

  Map<String, dynamic> toJson() => {
        "resourceId": resourceId,
        "parentId": parentId,
        "resourceName": resourceName,
      };
}
