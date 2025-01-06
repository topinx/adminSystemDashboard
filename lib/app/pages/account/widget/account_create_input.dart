import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/dropdown_btn.dart';

import '../controller/account_manage_controller.dart';

class AccountCreateInput extends StatelessWidget {
  const AccountCreateInput(
    this.text, {
    super.key,
    this.need,
    this.maxWidth,
    this.input,
    this.validator,
    this.formatter,
  });

  final String text;

  final TextEditingController? input;

  final List<TextInputFormatter>? formatter;

  final String? Function(String?)? validator;

  final bool? need;

  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    Widget textWidget = Text.rich(
      TextSpan(children: [
        TextSpan(
          text: (need ?? false) ? "*" : "",
          style: const TextStyle(color: Colors.red),
        ),
        TextSpan(text: "$text: "),
      ]),
      textAlign: TextAlign.end,
    );

    return Row(children: [
      SizedBox(width: 70, child: textWidget),
      const SizedBox(width: 5),
      ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth ?? 240),
        child: TextFormField(
          controller: input,
          validator: validator,
          inputFormatters: formatter,
          decoration: const InputDecoration(hintText: "请输入"),
        ),
      )
    ]);
  }
}

class AccountCreateAvatar extends StatelessWidget {
  const AccountCreateAvatar(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 70, child: Text("$text: ", textAlign: TextAlign.end)),
      const SizedBox(width: 5),
      GetBuilder<AccountManageController>(builder: (ctr) {
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
      GetBuilder<AccountManageController>(builder: (ctr) {
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

class AccountCreateGender extends StatelessWidget {
  const AccountCreateGender(this.onChanged, {super.key});

  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(width: 70, child: Text("性别: ", textAlign: TextAlign.end)),
      const SizedBox(width: 5),
      DropdownBtn(
        menuList: const ["男", "女"],
        width: 100,
        onChanged: onChanged,
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
        hint: const Center(child: Text("选择性别")),
      ),
    ]);
  }
}

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
            child: ctr.birthday == null
                ? Text("请选择",
                    style: Theme.of(context).inputDecorationTheme.hintStyle)
                : Text(
                    "${ctr.birthday!.year}-${ctr.birthday!.month}-${ctr.birthday!.day}"),
          ),
        );
      }),
    ]);
  }
}
