import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/preview_dialog.dart';
import 'package:top_back/app/widgets/table_title_text.dart';
import 'package:top_back/bean/bean_topic.dart';
import 'package:top_back/contants/app_constants.dart';

import '../controller/manage_topic_controller.dart';

class ManageTopicTable extends StatelessWidget {
  const ManageTopicTable({super.key});

  TableRow buildTableTitle(ManageTopicController ctr, int count) {
    bool select = ctr.selectList.isNotEmpty;
    bool selectAll = ctr.selectList.length == count && count > 0;

    return TableRow(
      decoration: const BoxDecoration(color: Colors.black12),
      children: [
        TableCell(child: TableSelect(ctr.onTapSelectAll, select, selectAll)),
        const TableCell(child: TableText("话题名称", true)),
        const TableCell(child: TableText("话题封面", true)),
        const TableCell(child: TableText("话题笔记数", true)),
        const TableCell(child: TableText("话题状态", true)),
        const TableCell(child: TableText("关联热搜", true)),
        const TableCell(child: TableText("创建时间", true)),
        const TableCell(child: TableText("操作", true)),
      ],
    );
  }

  TableRow buildTableRow(ManageTopicController ctr, BeanTopic bean) {
    bool contain = ctr.selectList.contains(bean);

    String status = ["禁用状态", "启用状态"][bean.status];

    return TableRow(
      children: [
        TableCell(
            child: TableSelect(() => ctr.onTapSelect(bean), false, contain)),
        TableCell(child: TableText(bean.name, false)),
        TableCell(child: buildCover(bean.avatar, 1)),
        TableCell(child: TableText("${bean.noteCnt}", false)),
        TableCell(child: TableText(status, false)),
        TableCell(child: TableText(bean.topSearch?.name ?? "", false)),
        TableCell(child: TableText(bean.createTime, false)),
        TableCell(child: buildOperate(ctr, bean)),
      ],
    );
  }

  Widget buildOperate(ManageTopicController ctr, BeanTopic bean) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        reverse: true,
        scrollDirection: Axis.horizontal,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
            onPressed: () => ctr.onTapEdit(bean),
            child: const Text("编辑", style: TextStyle(color: Color(0xFF3871BB))),
          ),
          TextButton(
            onPressed: () => ctr.onTapDelete(bean),
            child: const Text("删除", style: TextStyle(color: Color(0xFF3871BB))),
          ),
          const SizedBox(width: 20),
        ]),
      ),
    );
  }

  Widget buildCover(String cover, int type) {
    DecorationImage? image;
    if (cover.isNotEmpty) {
      image =
          DecorationImage(image: NetworkImage(AppConstants.imgLink + cover));
    }

    return GestureDetector(
      onTap: () => onTapCover(cover, type),
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 50,
        decoration: BoxDecoration(image: image),
      ),
    );
  }

  void onTapCover(String cover, int type) {
    Get.dialog(PreviewDialog(data: cover, type: type));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: GetBuilder<ManageTopicController>(
          id: "check-table",
          builder: (ctr) {
            int start = (ctr.pageNum - 1) * ctr.pageSize;
            int end = start + ctr.pageSize;
            end = end > ctr.beanList.length ? ctr.beanList.length : end;

            List<BeanTopic> tempList = ctr.beanList.sublist(start, end);
            return Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                1: FlexColumnWidth(),
                2: FlexColumnWidth(1.5),
                3: FlexColumnWidth(),
                4: FlexColumnWidth(),
                5: FlexColumnWidth(),
                6: FlexColumnWidth(),
                7: FlexColumnWidth(),
              },
              children: [
                buildTableTitle(ctr, tempList.length),
                ...List.generate(
                    tempList.length, (i) => buildTableRow(ctr, tempList[i])),
              ],
            );
          }),
    );
  }
}
