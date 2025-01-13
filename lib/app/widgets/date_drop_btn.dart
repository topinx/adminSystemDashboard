import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';

class DateDropBtn extends StatefulWidget {
  const DateDropBtn(this.hint, {super.key, required this.onChange});

  final String hint;

  final Function(String) onChange;

  @override
  State<DateDropBtn> createState() => _DateDropBtnState();
}

class _DateDropBtnState extends State<DateDropBtn> {
  DateTime? dateTime;

  String get dateText {
    if (dateTime == null) return widget.hint;
    String year = "${dateTime!.year}".padLeft(4, "0");
    String month = "${dateTime!.month}".padLeft(2, "0");
    String day = "${dateTime!.day}".padLeft(2, "0");
    return "$year-$month-$day";
  }

  void onTapDatePicker() async {
    DateTime? date = await showBoardDateTimePicker(
      context: context,
      radius: 0,
      onTopActionBuilder: (_) => resetButton(),
      pickerType: DateTimePickerType.date,
      options: const BoardDateTimeOptions(
        inputable: false,
        backgroundColor: Color(0xFFF5F5F5),
        foregroundColor: Colors.white,
      ),
      initialDate: dateTime,
      maximumDate: DateTime.now(),
      minimumDate: DateTime(1900, 1, 1),
    );

    if (date == null) return;
    dateTime = date;
    if (mounted) setState(() {});
    widget.onChange(dateText);
  }

  void onTapReset() {
    Navigator.of(context).pop();
    dateTime = null;
    if (mounted) setState(() {});
    widget.onChange("");
  }

  Widget resetButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onTapReset,
        child: const Text("重置", style: TextStyle(color: Color(0xFF3871BB))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapDatePicker,
      child: Container(
        width: 100,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFFEBEBEB), width: 1),
        ),
        child: Text(dateText, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
