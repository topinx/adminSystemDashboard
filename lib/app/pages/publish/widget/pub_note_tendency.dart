import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/select_item.dart';

class PubNoteTendency extends StatelessWidget {
  const PubNoteTendency({super.key});

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
      const SelectItem("男性", false),
      const SizedBox(width: 20),
      const SelectItem("女性", false),
      const SizedBox(width: 20),
      const SelectItem("综合", false),
    ]);
  }
}
