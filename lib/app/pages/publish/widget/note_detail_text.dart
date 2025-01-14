import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/select_item.dart';
import 'package:top_back/bean/bean_note_detail.dart';

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
        const Text(":  "),
        Expanded(child: Text(text2)),
      ]),
    );
  }
}

class NoteDetailTendency extends StatelessWidget {
  const NoteDetailTendency(this.detail, {super.key, required this.onTap});

  final BeanNoteDetail detail;

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(width: 60, child: Text("笔记偏好")),
        const Text(":"),
        const SizedBox(width: 20),
        SelectItem("男性", detail.tendency == 1, onTap: () => onTap(1)),
        const SizedBox(width: 20),
        SelectItem("女性", detail.tendency == 2, onTap: () => onTap(2)),
        const SizedBox(width: 20),
        SelectItem("综合", detail.tendency == 3, onTap: () => onTap(3)),
      ]),
    );
  }
}
