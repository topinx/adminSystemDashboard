import 'package:flutter/material.dart';

class NoteDetailButtons extends StatelessWidget {
  const NoteDetailButtons({super.key});

  @override
  Widget build(BuildContext context) {
    ButtonStyle style = OutlinedButton.styleFrom(
      fixedSize: const Size.fromWidth(100),
      side: const BorderSide(color: Colors.black),
    );

    return Row(children: [
      OutlinedButton(
        onPressed: () {},
        style: style,
        child: const Text("上一篇"),
      ),
      const Spacer(),
      OutlinedButton(
        onPressed: () {},
        style: style,
        child: const Text("审核通过"),
      ),
      const SizedBox(width: 20),
      OutlinedButton(
        onPressed: () {},
        style: style,
        child: const Text("审核不通过"),
      ),
      const SizedBox(width: 20),
      OutlinedButton(
        onPressed: () {},
        style: style,
        child: const Text("通过并推荐"),
      ),
      const SizedBox(width: 20),
      OutlinedButton(
        onPressed: () {},
        style: style,
        child: const Text("违规"),
      ),
      const Spacer(),
      OutlinedButton(
        onPressed: () {},
        style: style,
        child: const Text("下一篇"),
      ),
    ]);
  }
}
