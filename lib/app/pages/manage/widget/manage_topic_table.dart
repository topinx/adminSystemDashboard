import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/table_title_text.dart';

class ManageTopicTable extends StatelessWidget {
  const ManageTopicTable({super.key});

  TableRow buildTableTitle() {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.black12),
      children: [
        TableCell(child: TableSelect(() {}, false, false)),
        const TableCell(child: TableText("话题名称", true)),
        const TableCell(child: TableText("话题封面", true)),
        const TableCell(child: TableText("话题笔记数", true)),
        const TableCell(child: TableText("话题状态", true)),
        const TableCell(child: TableText("关联热搜", true)),
        const TableCell(child: TableText("创建时间", true)),
        const TableCell(child: TableText("创建人", true)),
        const TableCell(child: TableText("操作", true)),
      ],
    );
  }

  TableRow buildTableRow() {
    return TableRow(
      children: [
        TableCell(child: TableSelect(() {}, false, false)),
        const TableCell(child: TableText("", false)),
        TableCell(child: buildCover()),
        const TableCell(child: TableText("", false)),
        const TableCell(child: TableText("", false)),
        const TableCell(child: TableText("", false)),
        const TableCell(child: TableText("", false)),
        const TableCell(child: TableText("2020-01-01", false)),
        TableCell(child: buildOperate()),
      ],
    );
  }

  Widget buildOperate() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: const Text("编辑", style: TextStyle(color: Color(0xFF3871BB))),
      ),
    );
  }

  Widget buildCover() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(color: Colors.black12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          1: FlexColumnWidth(),
          2: FlexColumnWidth(1.5),
          3: FlexColumnWidth(),
          4: FlexColumnWidth(),
          5: FlexColumnWidth(),
          6: FlexColumnWidth(),
          7: FlexColumnWidth(),
          8: FlexColumnWidth(),
        },
        children: [
          buildTableTitle(),
          ...List.generate(10, (i) => buildTableRow()),
        ],
      ),
    );
  }
}
