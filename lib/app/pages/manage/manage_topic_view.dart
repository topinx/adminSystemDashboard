import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/dropdown_btn.dart';
import 'package:top_back/app/widgets/page_indicator.dart';
import 'package:top_back/app/widgets/view_container.dart';

import '../account/widget/account_note_input.dart';
import 'controller/manage_topic_controller.dart';
import 'widget/manage_topic_table.dart';

class ManageTopicView extends StatefulWidget {
  const ManageTopicView({super.key});

  @override
  State<ManageTopicView> createState() => _ManageTopicViewState();
}

class _ManageTopicViewState extends State<ManageTopicView> {
  final ManageTopicController ctr = Get.find<ManageTopicController>();

  Widget buildFilterButton() {
    ButtonStyle style =
        OutlinedButton.styleFrom(fixedSize: const Size.fromWidth(100));

    TextStyle textStyle2 = const TextStyle(fontSize: 14, color: Colors.black);

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      OutlinedButton(
          style: style, onPressed: ctr.onTapCreate, child: const Text("创建")),
      const SizedBox(width: 30),
      DropdownBtn(
          hint: "批量处理",
          width: 100,
          height: 36,
          onChanged: (_) {},
          selectedItemBuilder: (_) => [
                Center(child: Text("批量处理", style: textStyle2)),
                Center(child: Text("批量处理", style: textStyle2)),
              ],
          menuList: const ["批量封禁", "批量删除"]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        AccountNoteInput(ctr: ctr.inputName, onTap: ctr.onTapSearch),
        const SizedBox(height: 40),
        buildFilterButton(),
        const SizedBox(height: 20),
        const Expanded(child: ManageTopicTable()),
        GetBuilder<ManageTopicController>(
          id: "check-page",
          builder: (ctr) => PageIndicator(
            itemCount: ctr.topicCnt,
            onTapPage: ctr.onTapPage,
            curPage: ctr.pageNum,
            onSizeChang: ctr.onPageSizeChanged,
          ),
        )
      ]),
    );
  }
}
