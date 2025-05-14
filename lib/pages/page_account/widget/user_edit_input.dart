import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_back/pages/widget/input_edit.dart';
import 'package:top_back/pages/widget/time_picker.dart';
import 'package:top_back/util/utils.dart';

class UserEditInput extends StatelessWidget {
  const UserEditInput({
    super.key,
    required this.input,
    required this.enable,
    this.formatter,
    this.validator,
    required this.maxLine,
  });

  final TextEditingController? input;

  final bool enable;

  final List<TextInputFormatter>? formatter;

  final String? Function(String?)? validator;

  final int maxLine;

  UserEditInput.nick(this.input, this.enable)
      : formatter = [LengthLimitingTextInputFormatter(30)],
        validator = Utils.onValidatorNick,
        maxLine = 1;

  UserEditInput.phone(this.input, this.enable)
      : formatter = [
          LengthLimitingTextInputFormatter(15),
          FilteringTextInputFormatter.digitsOnly
        ],
        validator = Utils.onValidatorPhone,
        maxLine = 1;

  UserEditInput.email(this.input, this.enable)
      : formatter = [LengthLimitingTextInputFormatter(45)],
        validator = Utils.onValidatorEmail,
        maxLine = 1;

  UserEditInput.brief(this.input, this.enable)
      : formatter = [LengthLimitingTextInputFormatter(500)],
        validator = null,
        maxLine = 5;

  @override
  Widget build(BuildContext context) {
    return InputEdit(input, enable,
        formatter: formatter, validator: validator, maxLine: maxLine);
  }
}

class UserEditText extends StatelessWidget {
  const UserEditText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(maxWidth: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xFFE5E5E5), width: 1),
      ),
      child: Text(text, style: TextStyle(color: Colors.black, fontSize: 14)),
    );
  }
}

class UserEditDate extends StatelessWidget {
  const UserEditDate(this.text, this.enable, {super.key, this.onChanged});

  final String text;

  final bool enable;

  final Function(String)? onChanged;

  void onTapPicker(BuildContext context) async {
    if (!enable) return;

    RenderBox box = context.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    Offset offset = Offset(position.dx, position.dy - 250);

    var date = await showDialog(
      context: context,
      builder: (_) => Center(child: TimePicker(offset)),
    );

    if (date == null || date is! DateTime) return;
    String dateTime = date.toString().substring(0, 19);

    if (onChanged != null) onChanged!(dateTime);
  }

  Widget buildPicker() {
    Color color = enable ? Colors.blue : Colors.black;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(maxWidth: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.transparent,
        border: Border.all(
            color: enable ? Colors.blue : Color(0xFFE5E5E5), width: 1),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 14)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (c) => GestureDetector(
        onTap: () => onTapPicker(c),
        child: buildPicker(),
      ),
    );
  }
}
