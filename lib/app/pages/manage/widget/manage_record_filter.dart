import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/dropdown_btn.dart';
import 'package:top_back/app/widgets/note_drop_filter.dart';

class ManageRecordFilter extends StatelessWidget {
  const ManageRecordFilter({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(fontSize: 14);

    Widget content = Row(children: [
      const Text("审核人："),
      SizedBox(
        width: 120,
        height: 36,
        child: TextField(
          decoration: InputDecoration(
            hintText: "请输入并查找",
            hintStyle: textStyle1,
          ),
        ),
      ),
      const SizedBox(width: 20),
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
          menuList: const ["批量通过", "批量驳回"]),
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
