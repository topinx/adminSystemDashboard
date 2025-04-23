import 'package:top_back/router/router.dart';
import 'package:flutter/material.dart';

class Menu {
  int id = 0;

  String route = "";

  String text = "";

  IconData icon = Icons.account_circle;

  List<Menu> children = [];
}

Map<int, Menu> routeMap = {
  1: Menu()
    ..icon = Icons.account_circle
    ..text = "账号管理"
    ..id = 1
    ..route = "",
  2: Menu()
    ..icon = Icons.add
    ..text = "账号管理"
    ..id = 2
    ..route = RouterPath.path_account_manager,
  3: Menu()
    ..icon = Icons.add
    ..text = "我的账号"
    ..id = 3
    ..route = RouterPath.path_account_owner,
  4: Menu()
    ..icon = Icons.edit_note
    ..text = "内容管理"
    ..id = 4
    ..route = "",
  5: Menu()
    ..icon = Icons.add
    ..text = "笔记管理"
    ..id = 5
    ..route = RouterPath.path_manage_note,
  6: Menu()
    ..icon = Icons.add
    ..text = "话题管理"
    ..id = 6
    ..route = RouterPath.path_manage_topic,
  7: Menu()
    ..icon = Icons.add
    ..text = "表情管理"
    ..id = 7
    ..route = RouterPath.path_manage_emoji,
  8: Menu()
    ..icon = Icons.add
    ..text = "分类管理"
    ..id = 8
    ..route = RouterPath.path_manage_classify,
  9: Menu()
    ..icon = Icons.add
    ..text = "审核记录"
    ..id = 9
    ..route = RouterPath.path_manage_review,
  10: Menu()
    ..icon = Icons.search
    ..text = "搜索管理"
    ..id = 10
    ..route = "",
  11: Menu()
    ..icon = Icons.add
    ..text = "热搜管理"
    ..id = 11
    ..route = RouterPath.path_search_manage,
  12: Menu()
    ..icon = Icons.upload
    ..text = "上传发布"
    ..id = 12
    ..route = "",
  13: Menu()
    ..icon = Icons.add
    ..text = "推荐笔记"
    ..id = 13
    ..route = RouterPath.path_pub_recommend,
  14: Menu()
    ..icon = Icons.add
    ..text = "创意中心"
    ..id = 14
    ..route = RouterPath.path_pub_creative,
  15: Menu()
    ..icon = Icons.report
    ..text = "举报受理"
    ..id = 15
    ..route = "",
  16: Menu()
    ..icon = Icons.add
    ..text = "用户举报"
    ..id = 16
    ..route = RouterPath.path_report_user,
  17: Menu()
    ..icon = Icons.add
    ..text = "笔记举报"
    ..id = 17
    ..route = RouterPath.path_report_note,
};
