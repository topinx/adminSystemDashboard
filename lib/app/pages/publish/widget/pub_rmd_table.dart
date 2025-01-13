import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/table_title_text.dart';
import 'package:top_back/contants/app_constants.dart';

class PubRmdTable extends StatelessWidget {
  const PubRmdTable({super.key});

  TableRow buildTableTitle() {
    return const TableRow(
      decoration: BoxDecoration(color: Colors.black12),
      children: [
        TableCell(child: TableText("笔记", true)),
        TableCell(child: TableText("标题内容", true)),
        TableCell(child: TableText("审核状态", true)),
        TableCell(child: TableText("推荐状态", true)),
        TableCell(child: TableText("笔记类型", true)),
        TableCell(child: TableText("发布账号(后台)", true)),
        TableCell(child: TableText("发布账号(App)", true)),
        TableCell(child: TableText("发布时间", true)),
        TableCell(child: TableText("操作", true)),
      ],
    );
  }

  TableRow buildTableRow() {
    return TableRow(
      children: [
        TableCell(child: buildCover("")),
        const TableCell(child: TableText("", false)),
        const TableCell(child: TableText("未推荐", false)),
        const TableCell(child: TableText("图文笔记", false)),
        const TableCell(child: TableText("", false)),
        const TableCell(child: TableText("", false)),
        const TableCell(child: TableText("", false)),
        const TableCell(child: TableText("2020-01-01", false)),
        TableCell(child: TableCheck(() {})),
      ],
    );
  }

  Widget buildCover(String cover) {
    DecorationImage? image;
    if (cover.isNotEmpty) {
      image =
          DecorationImage(image: NetworkImage(AppConstants.imgLink + cover));
    }

    return GestureDetector(
      onTap: () => onTapCover(cover),
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 50,
        decoration: BoxDecoration(image: image),
      ),
    );
  }

  void onTapCover(String cover) {
    Widget image = Center(
      child: Image(image: NetworkImage(AppConstants.imgLink + cover)),
    );
    Get.dialog(image);
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
          8: FlexColumnWidth(),
          9: FlexColumnWidth(),
        },
        children: [
          buildTableTitle(),
          ...List.generate(10, (i) => buildTableRow()),
        ],
      ),
    );
  }
}
