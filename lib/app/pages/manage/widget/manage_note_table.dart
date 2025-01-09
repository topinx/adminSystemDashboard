import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/table_title_text.dart';

class ManageNoteTable extends StatelessWidget {
  const ManageNoteTable({super.key});

  TableRow buildTableTitle() {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.black12),
      children: [
        TableCell(child: TableSelect(() {}, false, false)),
        const TableCell(child: TableText("笔记", true)),
        const TableCell(child: TableText("标题内容", true)),
        const TableCell(child: TableText("推荐状态", true)),
        const TableCell(child: TableText("笔记类型", true)),
        const TableCell(child: TableText("笔记分类", true)),
        const TableCell(child: TableText("发布者", true)),
        const TableCell(child: TableText("发布时间", true)),
        const TableCell(child: TableText("操作", true)),
      ],
    );
  }

  TableRow buildTableRow() {
    return TableRow(
      children: [
        TableCell(child: TableSelect(() {}, false, false)),
        TableCell(child: buildNote()),
        const TableCell(child: TableText("", false)),
        const TableCell(child: TableText("未推荐", false)),
        const TableCell(child: TableText("图文笔记", false)),
        const TableCell(child: TableText("", false)),
        const TableCell(child: TableText("", false)),
        const TableCell(child: TableText("2020-01-01", false)),
        TableCell(child: buildOperate()),
      ],
    );
  }

  Widget buildOperate() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
          width: 140,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(
              onPressed: () {},
              child:
                  const Text("推荐", style: TextStyle(color: Color(0xFF3871BB))),
            ),
            TextButton(
              onPressed: () {},
              child:
                  const Text("删除", style: TextStyle(color: Color(0xFF3871BB))),
            ),
          ])),
    );
  }

  Widget buildNote() {
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
          5: FlexColumnWidth(1.5),
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
