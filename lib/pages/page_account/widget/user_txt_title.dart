import 'package:flutter/material.dart';

class UserTxtTitle extends StatelessWidget {
  const UserTxtTitle(this.text, {super.key, this.require = false});

  final String text;

  final bool require;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      if (require) TextSpan(text: "*", style: TextStyle(color: Colors.red)),
      TextSpan(text: text),
    ]));
  }
}
