import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

    textWidget = Align(alignment: Alignment.centerRight, child: textWidget);
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 70, height: 36, child: textWidget),
      const SizedBox(width: 5),
      Container(
        height: 36,
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
