import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputEdit extends StatelessWidget {
  InputEdit(
    this.input,
    this.enable, {
    super.key,
    this.formatter,
    this.validator,
    this.maxLine = 1,
    this.prefix,
    this.defBorder,
    this.maxWidth = 200,
  });

  final TextEditingController? input;

  final bool enable;

  final List<TextInputFormatter>? formatter;

  final String? Function(String?)? validator;

  final int maxLine;

  final Widget? prefix;

  final OutlineInputBorder? defBorder;

  final double maxWidth;

  final disableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Color(0xFFE5E5E5), width: 1),
  );

  final enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Colors.blue, width: 1),
  );

  final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Colors.redAccent, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    Color color = enable ? Colors.blue : Colors.black;
    return TextFormField(
      controller: input,
      enabled: enable,
      inputFormatters: formatter,
      style: TextStyle(color: color, fontSize: 14),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUnfocus,
      maxLines: maxLine,
      decoration: InputDecoration(
        constraints: BoxConstraints(maxWidth: maxWidth),
        isDense: true,
        counterText: "",
        prefixIcon: prefix,
        prefixIconConstraints: const BoxConstraints(maxWidth: 60),
        errorStyle: TextStyle(color: Colors.red, fontSize: 12),
        contentPadding: const EdgeInsets.all(10),
        disabledBorder: disableBorder,
        enabledBorder: defBorder ?? enableBorder,
        focusedBorder: enableBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
      ),
    );
  }
}
