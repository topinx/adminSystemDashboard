import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';

class AccountInfoBirth extends StatelessWidget {
  const AccountInfoBirth(this.text2,
      {super.key, this.enable, required this.onChange});

  final String text2;

  final bool? enable;

  final Function(String) onChange;

  Widget buildBirthDrop(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 240,
      child: BoardDateTimeInputField(
        enabled: enable,
        key: UniqueKey(),
        textStyle: const TextStyle(color: Colors.black, fontSize: 14),
        decoration: const InputDecoration(
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        pickerType: DateTimePickerType.date,
        options: const BoardDateTimeOptions(
          inputable: false,
          backgroundColor: Color(0xFFF5F5F5),
          foregroundColor: Colors.white,
        ),
        delimiter: "-",
        initialDate: text2.isEmpty ? null : DateTime.parse(text2),
        maximumDate: DateTime.now(),
        minimumDate: DateTime(1900, 1, 1),
        onResult: (BoardDateResult date) {
          String year = "${date.year}".padLeft(4, "0");
          String month = "${date.month}".padLeft(2, "0");
          String day = "${date.day}".padLeft(2, "0");
          onChange("$year-$month-$day");
        },
        onChanged: (DateTime date) {},
      ),
    );
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
