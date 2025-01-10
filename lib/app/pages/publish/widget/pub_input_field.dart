import 'package:flutter/material.dart';

class PubInputTitle extends StatelessWidget {
  const PubInputTitle({super.key});

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
      const SizedBox(
        height: 36,
        width: 320,
        child: TextField(decoration: InputDecoration(hintText: "请输入")),
      ),
    ]);
  }
}

class PubInputContent extends StatelessWidget {
  const PubInputContent({super.key});

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
      const SizedBox(
        width: 320,
        child: TextField(
          maxLines: 6,
          decoration: InputDecoration(
            hintText: "请输入",
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
        ),
      ),
    ]);
  }
}

class PubInputTopic extends StatelessWidget {
  const PubInputTopic({super.key});

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
      const SizedBox(
        height: 36,
        width: 320,
        child: TextField(
          decoration: InputDecoration(
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
          style: const TextStyle(color: Colors.black, fontSize: 14),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
        ),
      ),
    ]);
  }
}
