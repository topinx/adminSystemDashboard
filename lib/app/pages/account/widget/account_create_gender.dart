import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/dropdown_btn.dart';

import '../controller/account_create_controller.dart';

class AccountCreateGender extends StatelessWidget {
  const AccountCreateGender({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(width: 70, child: Text("性别: ", textAlign: TextAlign.end)),
      const SizedBox(width: 5),
      GetBuilder<AccountCreateController>(builder: (ctr) {
        return DropdownBtn(
          menuList: const ["男", "女"],
          width: 100,
          height: 36,
          init: ctr.gender - 1,
          onChanged: ctr.onGenderChanged,
          selectedItemBuilder: (_) => const [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Align(alignment: Alignment.centerLeft, child: Text("男")),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Align(alignment: Alignment.centerLeft, child: Text("女")),
            ),
          ],
          hint: "选择性别",
        );
      }),
    ]);
  }
}
