import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountNoteBar extends StatelessWidget {
  const AccountNoteBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 45,
      color: Colors.transparent,
      child: Row(children: [
        OutlinedButton(
          onPressed: Get.back,
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.transparent)),
          child: const Row(children: [
            Icon(Icons.arrow_back_ios_new, color: Colors.black12, size: 16),
            Text("返回"),
          ]),
        ),
        const Spacer(),
      ]),
    );
  }
}
