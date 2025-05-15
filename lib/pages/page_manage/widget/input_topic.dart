import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTopic extends StatelessWidget {
  InputTopic({super.key, this.input});

  final TextEditingController? input;

  final enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Color(0xFFE5E5E5), width: 1),
  );

  final focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Colors.blue, width: 1),
  );

  final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Colors.redAccent, width: 1),
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
    return TextFormField(
      controller: input,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'[ #@]')),
        LengthLimitingTextInputFormatter(100)
      ],
      style: TextStyle(color: Colors.blue, fontSize: 14),
      validator: onValidatorTopic,
      autovalidateMode: AutovalidateMode.onUnfocus,
      maxLines: 1,
      decoration: InputDecoration(
        constraints: const BoxConstraints(maxWidth: 200),
        isDense: true,
        counterText: "",
        prefixText: "#",
        prefixStyle: TextStyle(color: Colors.blue),
        errorStyle: TextStyle(color: Colors.red, fontSize: 12),
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: enableBorder,
        focusedBorder: focusBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
      ),
    );
  }
}
