import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/account_info_controller.dart';

class AccountInfoBar extends StatelessWidget {
  const AccountInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.transparent,
      child: GetBuilder<AccountInfoController>(builder: (ctr) {
        return Row(children: [
          OutlinedButton(
            onPressed: ctr.isEditView ? ctr.onTapEdit : Get.back,
            style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.transparent)),
            child: const Row(children: [
              Icon(Icons.arrow_back_ios_new, color: Colors.black12, size: 16),
              Text("返回"),
            ]),
          ),
          const Spacer(),
          if (ctr.isEditView) ...[
            OutlinedButton(
              onPressed: () {},
              style:
                  OutlinedButton.styleFrom(fixedSize: const Size.fromWidth(80)),
              child: const Text("重置信息"),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: () {},
              style:
                  OutlinedButton.styleFrom(fixedSize: const Size.fromWidth(80)),
              child: const Text("重置密码"),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: () {},
              style:
                  OutlinedButton.styleFrom(fixedSize: const Size.fromWidth(80)),
              child: const Text("保存"),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: ctr.onTapEdit,
              style:
                  OutlinedButton.styleFrom(fixedSize: const Size.fromWidth(80)),
              child: const Text("取消"),
            ),
          ] else
            IconButton(
                onPressed: ctr.onTapEdit,
                icon: const Icon(Icons.edit_note_outlined)),
        ]);
      }),
    );
  }
}
