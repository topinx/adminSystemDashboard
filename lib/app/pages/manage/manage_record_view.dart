import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:top_back/app/widgets/page_indicator.dart';
import 'package:top_back/app/widgets/view_container.dart';

import '../account/widget/account_note_input.dart';
import 'controller/manage_record_controller.dart';
import 'widget/manage_record_filter.dart';
import 'widget/manage_record_table.dart';

class ManageRecordView extends StatefulWidget {
  const ManageRecordView({super.key});

  @override
  State<ManageRecordView> createState() => _ManageRecordViewState();
}

class _ManageRecordViewState extends State<ManageRecordView> {
  final ManageRecordController ctr = Get.find<ManageRecordController>();

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        AccountNoteInput(ctr: ctr.inputSearch, onTap: ctr.onTapSearch),
        const SizedBox(height: 40),
        ManageRecordFilter(
          onChange: ctr.onFilterChange,
          onTimeChange: ctr.onTimeChange,
        ),
        const SizedBox(height: 20),
        const Expanded(child: ManageRecordTable()),
        GetBuilder<ManageRecordController>(
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
