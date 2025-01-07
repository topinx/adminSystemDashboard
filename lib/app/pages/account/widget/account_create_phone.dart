import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/account_manage_controller.dart';

class AccountCreatePhone extends StatelessWidget {
  const AccountCreatePhone({super.key});

  Widget buttonAreaCode(BuildContext context) {
    return GetBuilder<AccountManageController>(builder: (ctr) {
      return GestureDetector(
        onTap: () => ctr.onTapAreaCode(context),
        child: Container(
          height: 45,
          width: 60,
          margin: const EdgeInsets.only(right: 10),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(
              right: BorderSide(color: Color(0xFFEBEBEB), width: 1),
            ),
          ),
          alignment: Alignment.center,
          child: Text("+${ctr.phoneCode}"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final AccountManageController ctr = Get.find<AccountManageController>();

    Widget textWidget = const Text.rich(
      TextSpan(children: [
        TextSpan(text: "*", style: TextStyle(color: Colors.red)),
        TextSpan(text: "手机: "),
      ]),
      textAlign: TextAlign.end,
    );

    textWidget = Align(alignment: Alignment.centerRight, child: textWidget);
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 70, height: 45, child: textWidget),
      const SizedBox(width: 5),
      SizedBox(
        width: 240,
        child: TextFormField(
          controller: ctr.inputPhone,
          validator: ctr.validatorPhone,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'\d')),
            LengthLimitingTextInputFormatter(16),
          ],
          decoration: InputDecoration(
            hintText: "请输入",
            prefixIcon: buttonAreaCode(context),
          ),
        ),
      )
    ]);
  }
}
