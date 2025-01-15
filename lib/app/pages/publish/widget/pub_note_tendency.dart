import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/select_item.dart';
import 'package:top_back/bean/bean_draft.dart';

class PubNoteTendency extends StatelessWidget {
  const PubNoteTendency(this.detail, {super.key, required this.onTap});

  final BeanDraft detail;

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 14);
    return Row(children: [
      Container(
        height: 36,
        width: 80,
        alignment: Alignment.centerLeft,
        child: Text("笔记偏好：", style: textStyle),
      ),
      SelectItem("男性", detail.tendency == 1, onTap: () => onTap(1)),
      const SizedBox(width: 20),
      SelectItem("女性", detail.tendency == 2, onTap: () => onTap(2)),
      const SizedBox(width: 20),
      SelectItem("综合", detail.tendency == 3, onTap: () => onTap(3)),
    ]);
  }
}
