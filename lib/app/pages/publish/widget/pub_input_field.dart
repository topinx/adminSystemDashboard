import 'package:flutter/material.dart';

class PubInputTitle extends StatelessWidget {
  const PubInputTitle(this.ctr, {super.key});

  final TextEditingController ctr;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 14);

    return Row(children: [
      Container(
        height: 36,
        width: 80,
        alignment: Alignment.centerLeft,
        child: Text("笔记标题：", style: textStyle),
      ),
      SizedBox(
        height: 36,
        width: 320,
        child: TextField(
          controller: ctr,
          decoration: const InputDecoration(hintText: "请输入"),
        ),
      ),
    ]);
  }
}

class PubInputContent extends StatelessWidget {
  const PubInputContent(this.ctr, {super.key});

  final TextEditingController ctr;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 14);

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 36,
        width: 80,
        alignment: Alignment.centerLeft,
        child: Text("笔记正文：", style: textStyle),
      ),
      SizedBox(
        width: 320,
        child: TextField(
          maxLines: 6,
          controller: ctr,
          decoration: const InputDecoration(
            hintText: "请输入",
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
        ),
      ),
    ]);
  }
}

class PubInputTopic extends StatelessWidget {
  const PubInputTopic(this.ctr, {super.key});

  final TextEditingController ctr;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 14);

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 36,
        width: 80,
        alignment: Alignment.centerLeft,
        child: Text("笔记话题：", style: textStyle),
      ),
      SizedBox(
        height: 36,
        width: 320,
        child: TextField(
          controller: ctr,
          decoration: const InputDecoration(
            hintText: "请输入",
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
        ),
      ),
    ]);
  }
}

class PubInputOpen extends StatelessWidget {
  const PubInputOpen({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 14);

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 36,
        width: 80,
        alignment: Alignment.centerLeft,
        child: Text("笔记权限：", style: textStyle),
      ),
      SizedBox(
        height: 36,
        width: 180,
        child: TextFormField(
          initialValue: "公开可见",
          enabled: false,
          style: const TextStyle(color: Color(0xFFEBEBEB), fontSize: 14),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
        ),
      ),
    ]);
  }
}
