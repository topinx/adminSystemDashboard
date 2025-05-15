import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:top_back/bean/bean_topic.dart';
import 'package:top_back/constants/http_constants.dart';
import 'package:top_back/network/dio_request.dart';
import 'package:top_back/pages/widget/common_button.dart';
import 'package:top_back/pages/widget/input_search.dart';
import 'package:top_back/pages/widget/table/table_widget.dart';
import 'package:top_back/toast/toast.dart';

class ManageTopic extends StatefulWidget {
  const ManageTopic({super.key});

  @override
  State<ManageTopic> createState() => _ManageTopicState();
}

class _ManageTopicState extends State<ManageTopic> {
  final TextEditingController input = TextEditingController();

  TableController<BeanTopic> controller = TableController<BeanTopic>();

  final columns = ["话题名称", "话题封面", "话题笔记数", "话题状态", "关联热搜", "创建时间", "操作"];

  @override
  void initState() {
    super.initState();
    controller.enableSelect = true;
    controller.builder = buildTabRowList;
    controller.future = requestBeanList;

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
    controller.dataLen = dataLen;
    controller.refreshDatasource();
  }

  Future<List<BeanTopic>> requestBeanList(int page) async {
    final query = {
      "pageNo": page,
      "limit": 10,
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

  Future<void> requestModify(List<int> topics, [bool unSelect = true]) async {
    Toast.showLoading();
    await DioRequest().request(
      HttpConstant.topicStatus,
      method: DioMethod.POST,
      data: {"ids": topics, "status": 0},
    );
    Toast.dismissLoading();

    if (unSelect) {
      controller.onSelectAll(false);
    }
    controller.refreshDatasource();
  }

  Future<void> requestDelete(List<int> topics, [bool unSelect = true]) async {
    Toast.showLoading();
    await DioRequest().request(HttpConstant.topicDelete,
        method: DioMethod.POST, data: json.encode(topics));
    Toast.dismissLoading();

    controller.dataLen -= topics.length;
    if (unSelect) {
      controller.onSelectAll(false);
    }
    controller.refreshDatasource();
  }

  void onTapCreate() {}

  void onTapEdit(BeanTopic bean) async {}

  void onTapDelete(BeanTopic bean) async {
    bool? confirm = await Toast.showAlert("确定删除话题？");
    if (confirm == null || !confirm) return;
    await requestDelete([bean.id]);
  }

  ({String key, List<Widget> widgetList}) buildTabRowList(BeanTopic? bean) {
    if (bean == null) {
      return (key: "", widgetList: List.generate(7, (_) => TabPlace()));
    }

    String status = ["禁用状态", "启用状态"][bean.status];
    List<Widget> beanList = [
      TabText(bean.name),
      TabImage(bean.avatar),
      TabText("${bean.noteCnt}"),
      TabText(status),
      TabText(bean.topSearch?.name ?? ""),
      TabText(bean.createTime),
      Wrap(alignment: WrapAlignment.center, children: [
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
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).canvasColor,
      ),
      child: Column(children: [
        InputSearch(input, onTapSearch),
        const SizedBox(height: 50),
        buildFilterDrops(),
        const SizedBox(height: 20),
        Expanded(
          child: TableWidget(columns: columns, controller: controller),
        ),
      ]),
    );
  }
}
