import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/account_create_controller.dart';

class AccountCreateAvatar extends StatelessWidget {
  const AccountCreateAvatar(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 70, child: Text("$text: ", textAlign: TextAlign.end)),
      const SizedBox(width: 5),
      GetBuilder<AccountCreateController>(builder: (ctr) {
        return GestureDetector(
          onTap: ctr.onTapAvatar,
          child: Container(
            width: 120,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFEBEBEB),
              image: ctr.userAvatar == null
                  ? null
                  : DecorationImage(image: MemoryImage(ctr.userAvatar!)),
            ),
            alignment: Alignment.center,
            child: ctr.userAvatar == null ? const Text("点击上传图片") : null,
          ),
        );
      }),
    ]);
  }
}

class AccountCreateCover extends StatelessWidget {
  const AccountCreateCover(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 70, child: Text("$text: ", textAlign: TextAlign.end)),
      const SizedBox(width: 5),
      GetBuilder<AccountCreateController>(builder: (ctr) {
        return GestureDetector(
          onTap: ctr.onTapCover,
          child: Container(
            width: 120,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFEBEBEB),
              image: ctr.userCover == null
                  ? null
                  : DecorationImage(image: MemoryImage(ctr.userCover!)),
            ),
            alignment: Alignment.center,
            child: ctr.userCover == null ? const Text("点击上传图片") : null,
          ),
        );
      }),
    ]);
  }
}
