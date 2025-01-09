import 'package:flutter/material.dart';

import 'date_drop_btn.dart';
import 'dropdown_btn.dart';

class NoteDropStatus extends StatelessWidget {
  const NoteDropStatus({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(fontSize: 14);

    return Row(children: [
      const Text("审核状态："),
      DropdownBtn(
          width: 100,
          height: 36,
          init: 0,
          selectedItemBuilder: (_) => [
                Center(child: Text("全部", style: textStyle1)),
                Center(child: Text("未审核", style: textStyle1)),
                Center(child: Text("已审核", style: textStyle1)),
                Center(child: Text("未推荐", style: textStyle1)),
                Center(child: Text("已推荐", style: textStyle1)),
              ],
          onChanged: (_) {},
          menuList: const ["全部", "未审核", "已审核", "未推荐", "已推荐"]),
      const SizedBox(width: 20),
    ]);
  }
}

class NoteDropDate extends StatelessWidget {
  const NoteDropDate({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(fontSize: 14);

    return Row(children: [
      const Text("发布时间："),
      const DateDropBtn("开始日期"),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text("~", style: textStyle1),
      ),
      const DateDropBtn("结束日期"),
      const SizedBox(width: 20),
    ]);
  }
}

class NoteDropType extends StatelessWidget {
  const NoteDropType({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(fontSize: 14);

    return Row(children: [
      const Text("笔记类型："),
      DropdownBtn(
          width: 100,
          height: 36,
          init: 0,
          selectedItemBuilder: (_) => [
                Center(child: Text("全部", style: textStyle1)),
                Center(child: Text("图文笔记", style: textStyle1)),
                Center(child: Text("视频笔记", style: textStyle1)),
              ],
          onChanged: (_) {},
          menuList: const ["全部", "图文笔记", "视频笔记"]),
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

class NoteDropPreferences extends StatelessWidget {
  const NoteDropPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(fontSize: 14);

    return Row(children: [
      const Text("笔记偏好："),
      DropdownBtn(
          width: 100,
          height: 36,
          init: 0,
          selectedItemBuilder: (_) => [
                Center(child: Text("全部", style: textStyle1)),
                Center(child: Text("男性", style: textStyle1)),
                Center(child: Text("女性", style: textStyle1)),
                Center(child: Text("综合", style: textStyle1)),
              ],
          onChanged: (_) {},
          menuList: const ["全部", "男性", "女性", "综合"]),
      const SizedBox(width: 20),
    ]);
  }
}

class NoteDropLimit extends StatelessWidget {
  const NoteDropLimit({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(fontSize: 14);

    return Row(children: [
      const Text("笔记权限："),
      DropdownBtn(
          width: 100,
          height: 36,
          init: 0,
          selectedItemBuilder: (_) => [
                Center(child: Text("全部", style: textStyle1)),
                Center(child: Text("公开", style: textStyle1)),
                Center(child: Text("私有", style: textStyle1)),
                Center(child: Text("好友", style: textStyle1)),
              ],
          onChanged: (_) {},
          menuList: const ["全部", "公开", "私有", "好友"]),
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
