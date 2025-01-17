import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/table_list.dart';

import '../controller/report_user_controller.dart';

class ReportUserTable extends StatelessWidget {
  const ReportUserTable({super.key});

  Widget tableListBuilder(ReportUserController ctr, int index) {
    return const [
      TableListText(""),
      TableListText(""),
      TableListText(""),
      TableListCheck(),
    ][index];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportUserController>(
      id: "check-table",
      builder: (ctr) {
        return TableList(
          titleList: const ["被举报用户", "举报用户", "举报时间", "操作"],
          itemCount: 5,
          builder: (i, index) => tableListBuilder(ctr, index),
        );
      },
    );
  }
}
