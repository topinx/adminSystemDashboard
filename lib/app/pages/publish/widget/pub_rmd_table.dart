import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/table_list.dart';
import 'package:top_back/bean/bean_note_back.dart';

import '../controller/pub_recommend_controller.dart';

class PubRmdTable extends StatelessWidget {
  const PubRmdTable({super.key});

  final titleList = const [
    "笔记",
    "标题内容",
    "审核状态",
    "推荐状态",
    "笔记类型",
    "发布账号(后台)",
    "发布账号(App)",
    "发布时间",
    "操作"
  ];

  Widget tableListBuilder(
      PubRecommendController ctr, BeanNoteBack bean, int index) {
    String audited = ["未审核", "通过", "未通过", "违规"][bean.auditedStatus];
    String recommended = bean.recommendedStatus == null
        ? ""
        : ["不推荐", "推荐"][bean.recommendedStatus!];
    String noteType = ["", "图文笔记", "视频笔记"][bean.noteType];

    return [
      TableListCover(bean.cover),
      TableListText(bean.title),
      TableListText(audited),
      TableListText(recommended),
      TableListText(noteType),
      TableListText(bean.sysUserNickname),
      TableListText(bean.createNickname),
      TableListText(bean.createTime),
      TableListCheck(onTap: () => ctr.onTapCheck(bean)),
    ][index];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PubRecommendController>(
      id: "check-table",
      builder: (ctr) {
        int start = (ctr.pageNum - 1) * ctr.pageSize;
        int end = start + ctr.pageSize;
        end = end > ctr.beanList.length ? ctr.beanList.length : end;

        List<BeanNoteBack> tempList = ctr.beanList.sublist(start, end);

        return TableList(
          titleList: titleList,
          flexList: const [1, 2, 1, 1, 1, 1, 1, 1, 1],
          itemCount: tempList.length,
          builder: (i, index) => tableListBuilder(ctr, tempList[i], index),
        );
      },
    );
  }
}
