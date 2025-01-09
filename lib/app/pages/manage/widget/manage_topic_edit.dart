import 'package:flutter/material.dart';

class ManageTopicEdit extends StatefulWidget {
  const ManageTopicEdit({super.key});

  @override
  State<ManageTopicEdit> createState() => _ManageTopicEditState();
}

class _ManageTopicEditState extends State<ManageTopicEdit> {
  void onTapCover() {}

  void onTapBan() {}

  void onTapUnban() {}

  void onTapCancel() {
    Navigator.of(context).pop();
  }

  void onTapConfirm() {}

  Widget buildCoverContent() {
    return GestureDetector(
      onTap: onTapCover,
      child: Container(
        width: 120,
        height: 80,
        alignment: Alignment.center,
        color: const Color(0xFFEBEBEB),
        child: const Text("点击上传"),
      ),
    );
  }

  Widget buildEditContent() {
    return Column(children: [
      const Row(children: [
        SizedBox(width: 15),
        Text("编辑话题",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        Spacer(),
        CloseButton(),
      ]),
      Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 60, 20),
        height: 35,
        child: const Row(children: [
          Text("话题标题："),
          Expanded(child: TextField()),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 60, 20),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("话题封面："),
          buildCoverContent(),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 60, 20),
        child: Row(children: [
          const Text("封禁开关："),
          OutlinedButton(onPressed: onTapBan, child: const Text("封禁")),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: onTapUnban,
            style: OutlinedButton.styleFrom(
              fixedSize: const Size.fromWidth(100),
            ),
            child: const Text("解除封禁"),
          ),
        ]),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        OutlinedButton(onPressed: onTapCancel, child: const Text("取消")),
        const SizedBox(width: 10),
        OutlinedButton(onPressed: onTapConfirm, child: const Text("确定")),
        const SizedBox(width: 20)
      ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 320,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: buildEditContent(),
        ),
      ),
    );
  }
}
