import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/account_manage_controller.dart';

class AccountCreateBirth extends StatelessWidget {
  const AccountCreateBirth({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(
          width: 70, child: Text("出生日期: ", textAlign: TextAlign.end)),
      const SizedBox(width: 5),
      GetBuilder<AccountManageController>(builder: (ctr) {
        return GestureDetector(
          onTap: () => ctr.onTapBirth(context),
          child: Container(
            height: 45,
            width: 240,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFEBEBEB), width: 1),
            ),
            padding: const EdgeInsets.only(left: 10),
            child: ctr.birth == null
                ? Text("请选择",
                    style: Theme.of(context).inputDecorationTheme.hintStyle)
                : Text(
                    "${ctr.birth!.year}-${ctr.birth!.month}-${ctr.birth!.day}"),
          ),
        );
      }),
    ]);
  }
}
