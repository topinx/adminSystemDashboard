import 'package:flutter/material.dart';

import 'date_drop_btn.dart';
import 'dropdown_btn.dart';

enum NoteDropType { tendency, limit, type, audited, recommend }

extension NoteDropTypeExtension on NoteDropType {
  String get title => ["笔记偏好", "可见范围", "笔记类型", "审核状态", "推荐状态"][index];

  List<String> get menuList => [
        ["全部", "男性", "女性", "综合"],
        ["全部", "私密", "公开", "仅好友"],
        ["全部", "图文笔记", "视频笔记"],
        ["全部", "未审核", "通过", "未通过", "违规"],
        ["全部", "不推荐", "推荐"],
      ][index];

  List<int?> get tag => [
        [null, 1, 2, 3],
        [null, 0, 1, 2],
        [null, 1, 2],
        [null, 0, 1, 2, 3],
        [null, 0, 1],
      ][index];
}

class NoteDropFilter extends StatelessWidget {
  const NoteDropFilter(this.type, {super.key, this.onChange});

  final NoteDropType type;

  final Function(int?)? onChange;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(fontSize: 14);

    return Row(children: [
      Text("${type.title}："),
      DropdownBtn(
        width: 100,
        height: 36,
        init: 0,
        selectedItemBuilder: (_) => List.generate(
          type.menuList.length,
          (i) => Center(child: Text(type.menuList[i], style: textStyle1)),
        ),
        onChanged: (i) {
          if (onChange != null) onChange!(type.tag[i]);
        },
        menuList: type.menuList,
      ),
      const SizedBox(width: 20),
    ]);
  }
}

class NoteDropDate extends StatelessWidget {
  const NoteDropDate({super.key, required this.onChange});

  final Function(int, String) onChange;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(fontSize: 14);

    return Row(children: [
      const Text("发布时间："),
      DateDropBtn("开始日期", onChange: (string) => onChange(1, string)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text("~", style: textStyle1),
      ),
      DateDropBtn("结束日期", onChange: (string) => onChange(2, string)),
      const SizedBox(width: 20),
    ]);
  }
}

class NoteDropUser extends StatelessWidget {
  const NoteDropUser({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(fontSize: 14);

    return Row(children: [
      const Text("发布者："),
      DropdownBtn(
          width: 100,
          height: 36,
          init: 0,
          selectedItemBuilder: (_) => [
                Center(child: Text("全部", style: textStyle1)),
                Center(child: Text("mm-000", style: textStyle1)),
                Center(child: Text("mm-001", style: textStyle1)),
              ],
          onChanged: (_) {},
          menuList: const ["全部", "mm-000", "mm-001"]),
      const SizedBox(width: 20),
    ]);
  }
}

class NoteDropPub extends StatelessWidget {
  const NoteDropPub({super.key, required this.onTap});

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(fontSize: 14);

    Widget drop = DropdownBtn(
        width: 100,
        height: 36,
        hint: "上传笔记",
        selectedItemBuilder: (_) => [
              Center(child: Text("上传笔记", style: textStyle1)),
              Center(child: Text("上传笔记", style: textStyle1)),
            ],
        onChanged: onTap,
        menuList: const ["图文笔记", "视频笔记"]);

    return Align(alignment: Alignment.centerRight, child: drop);
  }
}
