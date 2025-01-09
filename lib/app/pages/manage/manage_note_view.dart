import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/page_indicator.dart';
import 'package:top_back/app/widgets/view_container.dart';

import '../account/widget/account_note_input.dart';
import 'widget/manage_note_filter.dart';
import 'widget/manage_note_table.dart';

class ManageNoteView extends StatefulWidget {
  const ManageNoteView({super.key});

  @override
  State<ManageNoteView> createState() => _ManageNoteViewState();
}

class _ManageNoteViewState extends State<ManageNoteView> {
  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        const AccountNoteInput(),
        const SizedBox(height: 40),
        const ManageNoteFilter(),
        const SizedBox(height: 20),
        const Expanded(child: ManageNoteTable()),
        PageIndicator(
            itemCount: 200, onTapPage: (_) {}, curPage: 1, onSizeChang: (_) {})
      ]),
    );
  }
}
