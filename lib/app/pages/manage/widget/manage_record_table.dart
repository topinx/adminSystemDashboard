import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/preview_dialog.dart';
import 'package:top_back/app/widgets/table_title_text.dart';
import 'package:top_back/bean/bean_note_list.dart';
import 'package:top_back/contants/app_constants.dart';

import '../controller/manage_record_controller.dart';

class ManageRecordTable extends StatelessWidget {
  const ManageRecordTable({super.key});

  TableRow buildTableTitle() {
    return const TableRow(
      decoration: BoxDecoration(color: Colors.black12),
      children: [
        TableCell(child: TableText("笔记", true)),
        TableCell(child: TableText("标题内容", true)),
        TableCell(child: TableText("审核状态", true)),
        TableCell(child: TableText("推荐状态", true)),
        TableCell(child: TableText("笔记类型", true)),
        TableCell(child: TableText("可见范围", true)),
        TableCell(child: TableText("发布时间", true)),
        TableCell(child: TableText("操作", true)),
      ],
    );
  }

  TableRow buildTableRow(ManageRecordController ctr, BeanNoteList bean) {
    String audited = ["未审核", "通过", "未通过", "违规"][bean.auditedStatus];
    String recommended = bean.recommendedStatus == null
        ? ""
        : ["不推荐", "推荐"][bean.recommendedStatus!];
    String noteType = ["", "图文笔记", "视频笔记"][bean.noteType];
    String status = ["私密", "公开", "好友可见"][bean.status];

    return TableRow(
      children: [
        TableCell(child: buildCover(bean.cover, bean.noteType)),
        TableCell(child: TableText(bean.title, false)),
        TableCell(child: TableText(audited, false)),
        TableCell(child: TableText(recommended, false)),
        TableCell(child: TableText(noteType, false)),
        TableCell(child: TableText(status, false)),
        TableCell(child: TableText(bean.createTime, false)),
        TableCell(child: TableCheck(() => ctr.onTapCheck(bean))),
      ],
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
      child: GetBuilder<ManageRecordController>(
          id: "check-table",
          builder: (ctr) {
            int start = (ctr.pageNum - 1) * ctr.pageSize;
            int end = start + ctr.pageSize;
            end = end > ctr.beanList.length ? ctr.beanList.length : end;

            List<BeanNoteList> tempList = ctr.beanList.sublist(start, end);
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
                8: FlexColumnWidth(),
              },
              children: [
                buildTableTitle(),
                ...List.generate(
                    tempList.length, (i) => buildTableRow(ctr, tempList[i])),
              ],
            );
          }),
    );
  }
}
