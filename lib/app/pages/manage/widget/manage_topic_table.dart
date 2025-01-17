import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/table_list.dart';
import 'package:top_back/bean/bean_topic.dart';

import '../controller/manage_topic_controller.dart';

class ManageTopicTable extends StatelessWidget {
  const ManageTopicTable({super.key});

  final titleList = const [
    "话题名称",
    "话题封面",
    "话题笔记数",
    "话题状态",
    "关联热搜",
    "创建时间",
    "操作"
  ];

  Widget tableListBuilder(
      ManageTopicController ctr, BeanTopic bean, int index) {
    String status = ["禁用状态", "启用状态"][bean.status];

    return [
      TableListText(bean.name),
      TableListCover(bean.avatar),
      TableListText("${bean.noteCnt}"),
      TableListText(status),
      TableListText(bean.topSearch?.name ?? ""),
      TableListText(bean.createTime),
      TableListBtn({
        "编辑": () => ctr.onTapEdit(bean),
        "删除": () => ctr.onTapDelete(bean),
      }),
    ][index];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageTopicController>(
      id: "check-table",
      builder: (ctr) {
        int start = (ctr.pageNum - 1) * ctr.pageSize;
        int end = start + ctr.pageSize;
        end = end > ctr.beanList.length ? ctr.beanList.length : end;

        List<BeanTopic> tempList = ctr.beanList.sublist(start, end);

        return TableList(
          titleList: titleList,
          flexList: const [2, 1, 1, 1, 1, 1, 1],
          onSelect: (selectList) {
            List<BeanTopic> select =
                selectList.map((i) => tempList[i]).toList();
            ctr.onSelectChanged(select);
          },
          itemCount: tempList.length,
          builder: (i, index) => tableListBuilder(ctr, tempList[i], index),
        );
      },
    );
  }
}
