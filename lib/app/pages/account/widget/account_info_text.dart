import 'package:flutter/material.dart';

class AccountInfoText extends StatelessWidget {
  const AccountInfoText(this.text1, this.text2, {super.key, this.enable});

  final String text1;

  final String text2;

  final bool? enable;

  Widget buildTextField(BuildContext context) {
    return TextFormField(
      enabled: enable ?? false,
      initialValue: text2,
      decoration: const InputDecoration(
        constraints: BoxConstraints(maxHeight: 25, maxWidth: 240),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: 60, child: Text(text1)),
        const Text(":  "),
        buildTextField(context),
      ]),
    );
  }
}
