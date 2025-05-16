import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_back/pages/widget/input_edit.dart';

class InputTopic extends StatelessWidget {
  InputTopic({super.key, this.input});

  final TextEditingController? input;

  final enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Color(0xFFE5E5E5), width: 1),
  );

  String? onValidatorTopic(String? string) {
    if (string == null || string.isEmpty) {
      return "话题不可为空";
    }
    bool hasMatch = RegExp(r"([^#^]+?)").hasMatch(string);
    if (!hasMatch) return "话题格式错误";

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InputEdit(
      input,
      true,
      formatter: [
        FilteringTextInputFormatter.deny(RegExp(r'[ #@]')),
        LengthLimitingTextInputFormatter(100)
      ],
      maxWidth: 300,
      prefix: Container(
        width: 30,
        alignment: Alignment.center,
        child: Text("#"),
      ),
      defBorder: enableBorder,
    );
  }
}
