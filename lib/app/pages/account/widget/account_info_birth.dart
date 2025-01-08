import 'package:flutter/material.dart';

class AccountInfoBirth extends StatefulWidget {
  const AccountInfoBirth(this.text2,
      {super.key, this.enable, required this.onChange});

  final String text2;

  final bool? enable;

  final Function(String) onChange;

  @override
  State<AccountInfoBirth> createState() => _AccountInfoBirthState();
}

class _AccountInfoBirthState extends State<AccountInfoBirth> {
  String text = "";

  @override
  void initState() {
    super.initState();
    text = widget.text2;
  }

  @override
  void didUpdateWidget(covariant AccountInfoBirth oldWidget) {
    super.didUpdateWidget(oldWidget);
    text = widget.text2;
  }

  void onTapDrop(BuildContext context) async {
    if (widget.enable != true) return;

    DateTime? birth = text.isEmpty ? null : DateTime.parse(text);
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: birth,
      firstDate: DateTime(1790, 1, 1),
      lastDate: DateTime.now(),
    );
    if (dateTime == null) return;
    String year = "${dateTime.year}".padLeft(4, "0");
    String month = "${dateTime.month}".padLeft(2, "0");
    String day = "${dateTime.day}".padLeft(2, "0");
    text = "$year-$month-$day";
    if (mounted) setState(() {});
    widget.onChange(text);
  }

  Widget buildBirthDrop(BuildContext context) {
    Border border = Border.all(
        color: widget.enable == true
            ? const Color(0xFFEBEBEB)
            : Colors.transparent,
        width: 1);

    Widget child = Container(
      height: 25,
      width: 240,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: border,
      ),
      child:
          Text(text, style: const TextStyle(color: Colors.black, fontSize: 14)),
    );

    return GestureDetector(onTap: () => onTapDrop(context), child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(width: 60, child: Text("出生日期")),
        const Text(":"),
        buildBirthDrop(context),
      ]),
    );
  }
}
