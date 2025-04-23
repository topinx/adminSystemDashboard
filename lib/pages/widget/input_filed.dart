import 'package:flutter/material.dart';

class InputFiled extends StatelessWidget {
  InputFiled(this.input, this.text, {super.key});

  final TextEditingController input;

  final String text;

  final enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Color(0xFFCECECE), width: 1),
  );

  final focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Colors.blue, width: 1),
  );

  final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Colors.redAccent, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(width: 100, child: Text(text)),
      Expanded(
        child: TextField(
          controller: input,
          decoration: InputDecoration(
            constraints: const BoxConstraints(minHeight: 25),
            isDense: true,
            enabledBorder: enableBorder,
            focusedBorder: focusBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
          ),
        ),
      ),
    ]);
  }
}
