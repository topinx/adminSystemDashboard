import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_back/bean/bean_topic.dart';
import 'package:top_back/constants/http_constants.dart';
import 'package:top_back/network/dio_request.dart';
import 'package:top_back/pages/widget/common_button.dart';
import 'package:top_back/pages/widget/input_search.dart';
import 'package:top_back/pages/widget/page_card.dart';
import 'package:top_back/pages/widget/table/async_table.dart';
import 'package:top_back/router/router.dart';
import 'package:top_back/toast/toast.dart';

class ManageTopic extends StatefulWidget {
  const ManageTopic({super.key});

  @override
  State<ManageTopic> createState() => _ManageTopicState();
}

class _ManageTopicState extends State<ManageTopic> {
  final TextEditingController input = TextEditingController();

  AsyncTableController<BeanTopic> controller =
      AsyncTableController<BeanTopic>();

  final columns = ["话题名称", "话题封面", "话题笔记数", "话题状态", "关联热搜", "创建时间", "操作"];

  @override
  void initState() {
    super.initState();
    controller.initialize(columns: columns, future: requestBeanList);

    WidgetsBinding.instance.addPostFrameCallback((_) => onTapSearch());
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    input.dispose();
  }

  void onTapSearch() async {
    int dataLen = await requestBeanCount();
    controller.updateDataLen(dataLen);
    controller.fetchData(page: 1);
  }

  Future<List<BeanTopic>> requestBeanList(int page, int limit) async {
    final query = {
      "pageNo": page,
      "limit": limit,
      "name": input.text,
    };

    final response =
        await DioRequest().request(HttpConstant.topicList, query: query);

    final tempList = response["list"] ?? [];
    List<BeanTopic> beanList = List<BeanTopic>.from(
      tempList.map((x) => BeanTopic.fromJson(x)),
    );
    return beanList;
  }

  Future<int> requestBeanCount() async {
    final query = {"name": input.text};

    return await DioRequest().request(HttpConstant.topicCnt, query: query);
  }

  void onDropChanged(String? string) async {
    if (controller.selection.isEmpty) return Toast.showToast("请先选择话题");

    if (string == "批量封禁") {
      bool? confirm = await Toast.showAlert("确定封禁话题？");
      if (confirm == null || !confirm) return;
      List<int> topics = controller.selection.map((x) => x.id).toList();
      requestModify(topics);
    } else if (string == "批量删除") {
      bool? confirm = await Toast.showAlert("确定删除话题？");
      if (confirm == null || !confirm) return;
      List<int> topics = controller.selection.map((x) => x.id).toList();
      await requestDelete(topics);
    }
  }

  Future<void> requestModify(List<int> topics) async {
    Toast.showLoading();
    var response = await DioRequest().request(
      HttpConstant.topicStatus,
      method: DioMethod.POST,
      data: {"ids": topics, "status": 0},
    );
    Toast.dismissLoading();

    if (response is bool && !response) return;
    Toast.showToast("操作成功", true);

    controller.fetchData();
  }

  Future<void> requestDelete(List<int> topics) async {
    Toast.showLoading();
    var response = await DioRequest().request(HttpConstant.topicDelete,
        method: DioMethod.POST, data: json.encode(topics));
    Toast.dismissLoading();

    if (response is bool && !response) return;
    Toast.showToast("删除成功", true);

    int dataLen = controller.dataLen;
    controller.updateDataLen(dataLen - topics.length);

    controller.fetchData();
  }

  void onTapModify(BeanTopic bean) async {
    if (bean.status == 1) {
      bool? confirm = await Toast.showAlert("确定封禁话题？");
      if (confirm == null || !confirm) return;
    }

    Toast.showLoading();
    var response = await DioRequest().request(
      HttpConstant.topicStatus,
      method: DioMethod.POST,
      data: {
        "ids": [bean.id],
        "status": bean.status == 0 ? 1 : 0
      },
    );
    Toast.dismissLoading();

    if (response is bool && !response) return;
    Toast.showToast("操作成功", true);
    controller.fetchData();
  }

  void onTapCreate() {
    context.push(RouterPath.path_topic_create);
  }

  void onTapEdit(BeanTopic bean) async {
    context.push(RouterPath.path_topic_create, extra: bean);
  }

  void onTapDelete(BeanTopic bean) async {
    bool? confirm = await Toast.showAlert("确定删除话题？");
    if (confirm == null || !confirm) return;
    await requestDelete([bean.id]);
  }

  ({String key, List<Widget> widgetList}) buildTabRowList(BeanTopic bean) {
    String status = ["禁用状态", "启用状态"][bean.status];
    List<Widget> beanList = [
      AsyncText(bean.name),
      AsyncImage(bean.avatar),
      AsyncText("${bean.noteCnt}"),
      AsyncText(status),
      AsyncText(bean.topSearch?.name ?? ""),
      AsyncText(bean.createTime),
      Wrap(alignment: WrapAlignment.center, children: [
        TxtButton(bean.status == 0 ? "启用" : "禁用",
            onTap: () => onTapModify(bean)),
        TxtButton("编辑", onTap: () => onTapEdit(bean)),
        TxtButton("删除", onTap: () => onTapDelete(bean)),
      ])
    ];

    return (key: "${bean.id}", widgetList: beanList);
  }

  Widget buildFilterDrops() {
    return LayoutBuilder(builder: (_, constraint) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        child: SizedBox(
          width: constraint.maxWidth < 1200 ? 1200 : constraint.maxWidth,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            BorderButton("创建", onTap: onTapCreate),
            const SizedBox(width: 20),
            DropButton(
              "批量处理",
              (_, __) async => ["批量封禁", "批量删除"],
              onChanged: onDropChanged,
            ),
          ]),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageCard(
      view: Column(children: [
        InputSearch(input, onTapSearch),
        const SizedBox(height: 50),
        buildFilterDrops(),
        const SizedBox(height: 20),
        Expanded(
          child: AsyncTable(ctr: controller, builder: buildTabRowList),
        ),
      ]),
    );
  }
}
