import 'dart:convert';

BeanInterCnt beanInterCntFromJson(String str) =>
    BeanInterCnt.fromJson(json.decode(str));

String beanInterCntToJson(BeanInterCnt data) => json.encode(data.toJson());

class BeanInterCnt {
  int beLikedCnt;
  int fansCnt;
  int followingCnt;
  int friendCnt;

  BeanInterCnt({
    this.beLikedCnt = 0,
    this.fansCnt = 0,
    this.followingCnt = 0,
    this.friendCnt = 0,
  });

  factory BeanInterCnt.fromJson(Map<String, dynamic> json) => BeanInterCnt(
        beLikedCnt: json["beLikedCnt"],
        fansCnt: json["fansCnt"],
        followingCnt: json["followingCnt"],
        friendCnt: json["friendCnt"],
      );

  Map<String, dynamic> toJson() => {
        "beLikedCnt": beLikedCnt,
        "fansCnt": fansCnt,
        "followingCnt": followingCnt,
        "friendCnt": friendCnt,
      };
}
