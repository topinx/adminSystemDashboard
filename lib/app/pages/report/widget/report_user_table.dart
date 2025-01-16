import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/table_title_text.dart';

import '../controller/report_user_controller.dart';

class ReportUserTable extends StatelessWidget {
  const ReportUserTable({super.key});

  TableRow buildTableTitle() {
    return const TableRow(
      decoration: BoxDecoration(color: Colors.black12),
      children: [
        TableCell(child: TableText("被举报用户", true)),
        TableCell(child: TableText("举报用户", true)),
        TableCell(child: TableText("举报时间", true)),
        TableCell(child: TableText("操作", true)),
      ],
    );
  }

  TableRow buildTableRow() {
    return TableRow(
      children: [
        const TableCell(child: TableText("", false)),
        const TableCell(child: TableText("", false)),
        const TableCell(child: TableText("", false)),
        TableCell(child: TableCheck(() {})),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: GetBuilder<ReportUserController>(
          id: "check-table",
          builder: (ctr) {
            return Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(),
                4: FlexColumnWidth(),
              },
              children: [
                buildTableTitle(),
                ...List.generate(10, (i) => buildTableRow()),
              ],
            );
          }),
    );
  }
}
