import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/back_app_bar.dart';
import 'package:top_back/app/widgets/page_indicator.dart';
import 'package:top_back/app/widgets/view_container.dart';

import 'controller/account_note_controller.dart';
import 'widget/account_note_filter.dart';
import 'widget/account_note_input.dart';
import 'widget/account_note_table.dart';

class AccountNoteView extends StatefulWidget {
  const AccountNoteView({super.key});

  @override
  State<AccountNoteView> createState() => _AccountNoteViewState();
}

class _AccountNoteViewState extends State<AccountNoteView> {
  final AccountNoteController ctr = Get.find<AccountNoteController>();

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        const BackAppBar(),
        const AccountNoteInput(),
        const SizedBox(height: 40),
        AccountNoteFilter(onChange: ctr.onFilterChange),
        const SizedBox(height: 20),
        const Expanded(child: AccountNoteTable()),
        PageIndicator(
            itemCount: 200, onTapPage: (_) {}, curPage: 1, onSizeChang: (_) {})
      ]),
    );
  }
}
