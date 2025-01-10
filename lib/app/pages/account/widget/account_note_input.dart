import 'package:flutter/material.dart';

class AccountNoteInput extends StatelessWidget {
  const AccountNoteInput({super.key, this.ctr, this.onTap});

  final TextEditingController? ctr;

  final Function()? onTap;

  Widget buildSearchButton(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
        child: Ink(
          width: 100,
          height: 45,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(4)),
          ),
          child: const Center(
            child: Text("搜索", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctr,
      decoration: InputDecoration(
        constraints: const BoxConstraints(maxWidth: 1200),
        hintText: "请输入笔记正文或标题进行查找",
        suffixIcon: buildSearchButton(context),
      ),
    );
  }
}
