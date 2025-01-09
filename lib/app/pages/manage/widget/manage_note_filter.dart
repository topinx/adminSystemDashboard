import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/dropdown_btn.dart';

class ManageNoteFilter extends StatelessWidget {
  const ManageNoteFilter({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(fontSize: 14);
    TextStyle textStyle2 = const TextStyle(fontSize: 14, color: Colors.black12);

    Widget content = Row(children: [
      const Text("笔记偏好："),
      DropdownBtn(
          width: 100,
          height: 36,
          init: 0,
          selectedItemBuilder: (_) => [
                Center(child: Text("全部", style: textStyle1)),
                Center(child: Text("男性", style: textStyle1)),
                Center(child: Text("女性", style: textStyle1)),
                Center(child: Text("综合", style: textStyle1)),
              ],
          onChanged: (_) {},
          menuList: const ["全部", "男性", "女性", "综合"]),
      const SizedBox(width: 20),
      const Text("笔记分类："),
      DropdownBtn(
          width: 100,
          height: 36,
          init: 0,
          selectedItemBuilder: (_) => [
                Center(child: Text("全部", style: textStyle1)),
              ],
          onChanged: (_) {},
          menuList: const ["全部"]),
      const SizedBox(width: 20),
      const Text("笔记类型："),
      DropdownBtn(
          width: 100,
          height: 36,
          init: 0,
          selectedItemBuilder: (_) => [
                Center(child: Text("全部", style: textStyle1)),
                Center(child: Text("图文笔记", style: textStyle1)),
                Center(child: Text("视频笔记", style: textStyle1)),
              ],
          onChanged: (_) {},
          menuList: const ["全部", "图文笔记", "视频笔记"]),
      const SizedBox(width: 20),
      const Text("推荐状态："),
      DropdownBtn(
          width: 100,
          height: 36,
          init: 0,
          selectedItemBuilder: (_) => [
                Center(child: Text("全部", style: textStyle1)),
                Center(child: Text("已推荐", style: textStyle1)),
                Center(child: Text("未推荐", style: textStyle1)),
              ],
          onChanged: (_) {},
          menuList: const ["全部", "已推荐", "未推荐"]),
      const SizedBox(width: 20),
      const Text("发布时间："),
      const ButtonDatePicker("开始日期"),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text("~", style: textStyle1),
      ),
      const ButtonDatePicker("结束日期"),
      const SizedBox(width: 20),
      DropdownBtn(
          hint: "批量处理",
          width: 100,
          height: 36,
          onChanged: (_) {},
          selectedItemBuilder: (_) => [
                Center(child: Text("批量处理", style: textStyle2)),
                Center(child: Text("批量处理", style: textStyle2)),
              ],
          menuList: const ["批量删除", "批量推荐"]),
    ]);

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        child: content,
      ),
    );
  }
}

class ButtonDatePicker extends StatefulWidget {
  const ButtonDatePicker(this.hint, {super.key});

  final String hint;

  @override
  State<ButtonDatePicker> createState() => _ButtonDatePickerState();
}

class _ButtonDatePickerState extends State<ButtonDatePicker> {
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
  }

  void onTapReset() {
    Navigator.of(context).pop();
    dateTime = null;
    if (mounted) setState(() {});
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
