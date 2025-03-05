import 'package:flutter/material.dart';

class PubCreateType extends StatelessWidget {
  const PubCreateType(this.createList, this.current,
      {super.key, required this.onTap});

  final List<String> createList;

  final int? current;

  final Function() onTap;

  String getCreateText() {
    if (current == null) return "是否上传至创意中心";
    if (current == 1) return "教学视频";
    if (current == 2) return "热门视频";

    if (createList.length > current! - 3) {
      String text = createList[current! - 3];
      if (!text.contains("|")) return "热门视频-$text";
      return "热门视频-${text.split("|").first}";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 14);
    return Row(children: [
      Container(
        height: 36,
        width: 80,
        alignment: Alignment.centerLeft,
        child: Text("创意中心：", style: textStyle),
      ),
      CheckButton(getCreateText(), current != null, onTap: onTap),
    ]);
  }
}

class CheckButton extends StatelessWidget {
  const CheckButton(this.text, this.active, {super.key, this.onTap});

  final bool active;

  final Function()? onTap;

  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 5),
      ),
      child: Row(children: [
        Text(
          text,
          style:
              TextStyle(color: active ? const Color(0xFF3871BB) : Colors.black),
        ),
        const SizedBox(width: 5),
        Icon(active ? Icons.check_box : Icons.check_box_outline_blank,
            size: 14, color: active ? const Color(0xFF3871BB) : Colors.black),
      ]),
    );
  }
}
