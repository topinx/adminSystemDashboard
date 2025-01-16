import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/view_container.dart';

import '../account/widget/account_note_input.dart';
import 'controller/report_user_controller.dart';
import 'widget/report_user_table.dart';

class ReportUserView extends StatefulWidget {
  const ReportUserView({super.key});

  @override
  State<ReportUserView> createState() => _ReportUserViewState();
}

class _ReportUserViewState extends State<ReportUserView> {
  final ReportUserController ctr = Get.find<ReportUserController>();

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        AccountNoteInput(ctr: ctr.inputSearch, onTap: ctr.onTapSearch),
        const SizedBox(height: 40),
        const Expanded(child: ReportUserTable()),
      ]),
    );
  }
}
