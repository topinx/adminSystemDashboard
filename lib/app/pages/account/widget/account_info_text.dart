import 'package:flutter/material.dart';

class AccountInfoText extends StatelessWidget {
  const AccountInfoText(this.text1, this.ctr, {super.key, this.enable});

  final String text1;

  final TextEditingController ctr;

  final bool? enable;

  Widget buildTextField(BuildContext context) {
    return TextField(
      enabled: enable ?? false,
      controller: ctr,
      style: const TextStyle(color: Colors.black),
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
        const Text(":"),
        buildTextField(context),
      ]),
    );
  }
}

class AccountInfoDrop extends StatelessWidget {
  const AccountInfoDrop(this.text1, this.status, this.menuList, {super.key});

  final String text1;

  final int status;

  final List<String> menuList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: 60, child: Text(text1)),
        const Text(":"),
      ]),
    );
  }
}
