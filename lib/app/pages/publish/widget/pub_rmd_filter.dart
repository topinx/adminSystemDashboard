import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/dropdown_btn.dart';
import 'package:top_back/app/widgets/note_drop_filter.dart';

class PubRmdFilter extends StatelessWidget {
  const PubRmdFilter({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(fontSize: 14);

    Widget content = Row(children: [
      const NoteDropUser(),
      const NoteDropType(),
      const NoteDropStatus(),
      const NoteDropDate(),
      DropdownBtn(
          hint: "批量处理",
          width: 100,
          height: 36,
          onChanged: (_) {},
          selectedItemBuilder: (_) => [
                Center(child: Text("批量处理", style: textStyle1)),
                Center(child: Text("批量处理", style: textStyle1)),
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
