import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/table_title_text.dart';

import '../controller/search_topic_controller.dart';

class SearchTopicTable extends StatelessWidget {
  const SearchTopicTable({super.key});

  TableRow buildTableTitle() {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.black12),
      children: [
        TableCell(child: TableSelect(() {}, false, false)),
        const TableCell(child: TableText("排序", true)),
        const TableCell(child: TableText("标题", true)),
        const TableCell(child: TableText("关联话题", true)),
        const TableCell(child: TableText("点击量", true)),
        const TableCell(child: TableText("创建时间", true)),
        const TableCell(child: TableText("操作", true)),
      ],
    );
  }

  TableRow buildTableRow() {
    return TableRow(
      children: [
        TableCell(child: TableSelect(() {}, false, false)),
        const TableCell(child: TableText("1", false)),
        const TableCell(child: TableText("", false)),
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
      child: GetBuilder<SearchTopicController>(
          id: "check-table",
          builder: (ctr) {
            return Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                1: FlexColumnWidth(),
                2: FlexColumnWidth(1.5),
                3: FlexColumnWidth(1.5),
                4: FlexColumnWidth(),
                5: FlexColumnWidth(),
                6: FlexColumnWidth(1.5),
              },
              children: [
                buildTableTitle(),
                ...List.generate(50, (i) => buildTableRow()),
              ],
            );
          }),
    );
  }
}
