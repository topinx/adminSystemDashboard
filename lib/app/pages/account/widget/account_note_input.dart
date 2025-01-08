import 'package:flutter/material.dart';

class AccountNoteInput extends StatelessWidget {
  const AccountNoteInput({super.key});

  Widget buildSearchButton(BuildContext context) {
    return Container(
      width: 100,
      height: 45,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.horizontal(right: Radius.circular(4)),
      ),
      child: const Text("搜索", style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        constraints: const BoxConstraints(maxWidth: 1200),
        hintText: "请输入笔记正文或标题进行查找",
        suffixIcon: buildSearchButton(context),
      ),
    );
  }
}
