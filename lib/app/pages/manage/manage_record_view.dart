import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/page_indicator.dart';
import 'package:top_back/app/widgets/view_container.dart';

import '../account/widget/account_note_input.dart';
import 'widget/manage_record_filter.dart';
import 'widget/manage_record_table.dart';

class ManageRecordView extends StatefulWidget {
  const ManageRecordView({super.key});

  @override
  State<ManageRecordView> createState() => _ManageRecordViewState();
}

class _ManageRecordViewState extends State<ManageRecordView> {
  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        const AccountNoteInput(),
        const SizedBox(height: 40),
        const ManageRecordFilter(),
        const SizedBox(height: 20),
        const Expanded(child: ManageRecordTable()),
        PageIndicator(
            itemCount: 200, onTapPage: (_) {}, curPage: 1, onSizeChang: (_) {})
      ]),
    );
  }
}
