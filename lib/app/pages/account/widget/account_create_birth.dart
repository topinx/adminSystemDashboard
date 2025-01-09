import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/account_manage_controller.dart';

class AccountCreateBirth extends StatelessWidget {
  const AccountCreateBirth({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(
          width: 70, child: Text("出生日期: ", textAlign: TextAlign.end)),
      const SizedBox(width: 5),
      GetBuilder<AccountManageController>(builder: (ctr) {
        return SizedBox(
          width: 240,
          height: 45,
          child: BoardDateTimeInputField(
            key: UniqueKey(),
            decoration: const InputDecoration(hintText: "请选择"),
            pickerType: DateTimePickerType.date,
            options: const BoardDateTimeOptions(
              inputable: false,
              backgroundColor: Color(0xFFF5F5F5),
              foregroundColor: Colors.white,
            ),
            delimiter: "-",
            initialDate: ctr.birth,
            maximumDate: DateTime.now(),
            minimumDate: DateTime(1900, 1, 1),
            onResult: (BoardDateResult date) =>
                ctr.birth = DateTime(date.year, date.month, date.day),
            onChanged: (DateTime date) {},
          ),
        );
      }),
    ]);
  }
}
