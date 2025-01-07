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
    required this.beLikedCnt,
    required this.fansCnt,
    required this.followingCnt,
    required this.friendCnt,
  });

  BeanInterCnt.empty()
      : beLikedCnt = 0,
        fansCnt = 0,
        followingCnt = 0,
        friendCnt = 0;

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
