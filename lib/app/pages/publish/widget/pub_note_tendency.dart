import 'package:flutter/material.dart';

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
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: const Row(children: [
          Icon(Icons.radio_button_unchecked, size: 14),
          SizedBox(width: 5),
          Text("男性")
        ]),
      ),
      const SizedBox(width: 20),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: const Row(children: [
          Icon(Icons.radio_button_unchecked, size: 14),
          SizedBox(width: 5),
          Text("女性")
        ]),
      ),
      const SizedBox(width: 20),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: const Row(children: [
          Icon(Icons.radio_button_unchecked, size: 14),
          SizedBox(width: 5),
          Text("综合")
        ]),
      ),
    ]);
  }
}
