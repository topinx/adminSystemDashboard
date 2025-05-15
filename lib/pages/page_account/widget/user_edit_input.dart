import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_back/pages/widget/input_edit.dart';
import 'package:top_back/pages/widget/phone_code/phone_code_sheet.dart';
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
    this.prefix,
  });

  final TextEditingController? input;

  final bool enable;

  final List<TextInputFormatter>? formatter;

  final String? Function(String?)? validator;

  final int maxLine;

  final Widget? prefix;

  UserEditInput.nick(this.input, this.enable)
      : formatter = [LengthLimitingTextInputFormatter(30)],
        validator = Utils.onValidatorNick,
        maxLine = 1,
        prefix = null;

  UserEditInput.phone(this.input, this.enable, this.prefix)
      : formatter = [
          LengthLimitingTextInputFormatter(15),
          FilteringTextInputFormatter.digitsOnly
        ],
        validator = Utils.onValidatorPhone,
        maxLine = 1;

  UserEditInput.email(this.input, this.enable)
      : formatter = [LengthLimitingTextInputFormatter(45)],
        validator = Utils.onValidatorEmail,
        maxLine = 1,
        prefix = null;

  UserEditInput.brief(this.input, this.enable)
      : formatter = [LengthLimitingTextInputFormatter(500)],
        validator = null,
        maxLine = 5,
        prefix = null;

  UserEditInput.password(this.input, this.enable)
      : formatter = [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z]')),
          LengthLimitingTextInputFormatter(18),
        ],
        validator = Utils.onValidatorPwd,
        maxLine = 1,
        prefix = null;

  @override
  Widget build(BuildContext context) {
    return InputEdit(
      input,
      enable,
      formatter: formatter,
      validator: validator,
      maxLine: maxLine,
      prefix: prefix,
    );
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
    Offset offset = Offset(position.dx, position.dy - 290);

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

class PhonePrefix extends StatefulWidget {
  const PhonePrefix(this.code, this.enable, {super.key, this.onChanged});

  final String code;

  final bool enable;

  final Function(String)? onChanged;

  @override
  State<PhonePrefix> createState() => _PhonePrefixState();
}

class _PhonePrefixState extends State<PhonePrefix> {
  String code = "";

  @override
  void initState() {
    super.initState();
    code = widget.code;
  }

  @override
  void didUpdateWidget(covariant PhonePrefix oldWidget) {
    super.didUpdateWidget(oldWidget);
    code = widget.code;
  }

  void onTapCode() async {
    if (!widget.enable) return;
    var codeString =
        await showDialog(context: context, builder: (_) => PhoneCodeSheet());
    if (codeString == null) return;
    code = "+$codeString";
    if (mounted) setState(() {});

    if (widget.onChanged != null) {
      widget.onChanged!("+$codeString");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCode,
      child: Container(
        height: 30,
        width: 50,
        color: Colors.transparent,
        margin: const EdgeInsets.only(right: 5),
        alignment: Alignment.center,
        child: Row(children: [
          Expanded(child: Center(child: Text(code))),
          Container(width: 1, height: 20, color: Color(0xFF979797))
        ]),
      ),
    );
  }
}
