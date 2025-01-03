import 'package:flutter/material.dart';

class AccountInputField extends StatelessWidget {
  const AccountInputField(this.text, this.ctr, {super.key});

  final String text;

  final TextEditingController ctr;

  Widget buildTextField(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 240),
          child: TextField(
            controller: ctr,
            decoration: const InputDecoration(hintText: "请输入"),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(text)),
          const SizedBox(width: 5),
          Expanded(child: buildTextField(context)),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
