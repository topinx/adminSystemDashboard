import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/back_app_bar.dart';
import 'package:top_back/app/widgets/dropdown_btn.dart';
import 'package:top_back/app/widgets/page_indicator.dart';
import 'package:top_back/app/widgets/view_container.dart';

import 'widget/account_note_input.dart';
import 'widget/account_note_table.dart';

class AccountNoteView extends StatefulWidget {
  const AccountNoteView({super.key});

  @override
  State<AccountNoteView> createState() => _AccountNoteViewState();
}

class _AccountNoteViewState extends State<AccountNoteView> {
  Widget buildButtonContent() {
    TextStyle textStyle2 = const TextStyle(fontSize: 14);

    return Align(
      alignment: Alignment.centerRight,
      child: DropdownBtn(
          width: 100,
          height: 36,
          init: 0,
          selectedItemBuilder: (_) => [
                Center(child: Text("全部", style: textStyle2)),
                Center(child: Text("未审核", style: textStyle2)),
                Center(child: Text("已审核", style: textStyle2)),
                Center(child: Text("未推荐", style: textStyle2)),
                Center(child: Text("已推荐", style: textStyle2)),
              ],
          onChanged: (_) {},
          menuList: const ["全部", "未审核", "已审核", "未推荐", "已推荐"]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        const BackAppBar(),
        const AccountNoteInput(),
        const SizedBox(height: 40),
        buildButtonContent(),
        const SizedBox(height: 20),
        const Expanded(child: AccountNoteTable()),
        PageIndicator(
            itemCount: 200, onTapPage: (_) {}, curPage: 1, onSizeChang: (_) {})
      ]),
    );
  }
}
