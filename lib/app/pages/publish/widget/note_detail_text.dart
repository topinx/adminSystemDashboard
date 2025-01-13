import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/select_item.dart';

class NoteDetailText extends StatelessWidget {
  const NoteDetailText(this.text1, this.text2, {super.key});

  final String text1;

  final String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(width: 60, child: Text(text1)),
        const Text(":"),
        Expanded(child: Text(text2)),
      ]),
    );
  }
}

class NoteDetailTendency extends StatelessWidget {
  const NoteDetailTendency({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
      child:
          const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(width: 60, child: Text("笔记偏好")),
        Text(":"),
        SizedBox(width: 20),
        SelectItem("男性", false),
        SizedBox(width: 20),
        SelectItem("女性", false),
        SizedBox(width: 20),
        SelectItem("综合", false),
      ]),
    );
  }
}
