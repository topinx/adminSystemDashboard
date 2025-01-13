import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/page_indicator.dart';
import 'package:top_back/app/widgets/view_container.dart';

import '../account/widget/account_note_input.dart';
import 'controller/manage_note_controller.dart';
import 'widget/manage_note_filter.dart';
import 'widget/manage_note_table.dart';

class ManageNoteView extends StatefulWidget {
  const ManageNoteView({super.key});

  @override
  State<ManageNoteView> createState() => _ManageNoteViewState();
}

class _ManageNoteViewState extends State<ManageNoteView> {
  final ManageNoteController ctr = Get.find<ManageNoteController>();

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        AccountNoteInput(ctr: ctr.inputSearch, onTap: ctr.onTapSearch),
        const SizedBox(height: 40),
        ManageNoteFilter(
          onChange: ctr.onFilterChange,
          onTimeChange: ctr.onTimeChange,
        ),
        const SizedBox(height: 20),
        const Expanded(child: ManageNoteTable()),
        GetBuilder<ManageNoteController>(
          id: "check-page",
          builder: (ctr) => PageIndicator(
            itemCount: ctr.checkCnt,
            onTapPage: ctr.onTapPage,
            curPage: ctr.pageNum,
            onSizeChang: ctr.onPageSizeChanged,
          ),
        ),
      ]),
    );
  }
}
