import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/table_list.dart';
import 'package:top_back/bean/bean_hot_search.dart';

import '../controller/search_topic_controller.dart';

class SearchTopicTable extends StatelessWidget {
  const SearchTopicTable({super.key});

  Widget tableListBuilder(
      SearchTopicController ctr, BeanHotSearch bean, int index) {
    return [
      TableListText("${bean.orderId}"),
      TableListText(bean.title),
      TableListText(bean.topicName),
      TableListText("${bean.clickCnt}"),
      TableListText(bean.createTime),
      TableListBtn({
        "置顶": () => ctr.onTapPinned(bean),
        "编辑": () => ctr.onTapEdit(bean),
        "删除": () => ctr.onTapDelete(bean),
      }),
    ][index];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchTopicController>(
      id: "check-table",
      builder: (ctr) {
        return TableList(
          titleList: const ["排序", "标题", "关联话题", "点击量", "创建时间", "操作"],
          itemCount: ctr.beanList.length,
          flexList: const [1, 2, 2, 1, 1, 2],
          onSelect: ctr.onSelectChanged,
          enableOrder: ctr.isEditSort,
          onReorder: (o, n) {
            var temp = ctr.beanList.removeAt(o);
            ctr.beanList.insert(n, temp);
          },
          builder: (i, index) => tableListBuilder(ctr, ctr.beanList[i], index),
        );
      },
    );
  }
}
