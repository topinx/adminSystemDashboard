import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:top_back/bean/bean_hot.dart';
import 'package:top_back/constants/http_constants.dart';
import 'package:top_back/network/dio_request.dart';
import 'package:top_back/pages/page_search/provider/search_provider.dart';
import 'package:top_back/pages/page_search/widget/search_sort_switch.dart';
import 'package:top_back/pages/widget/common_button.dart';
import 'package:top_back/pages/widget/input_search.dart';
import 'package:top_back/pages/widget/page_card.dart';
import 'package:top_back/pages/widget/table/async_table.dart';
import 'package:top_back/router/router.dart';
import 'package:top_back/toast/toast.dart';

class SearchManage extends ConsumerStatefulWidget {
  const SearchManage({super.key});

  @override
  ConsumerState<SearchManage> createState() => _SearchManageState();
}

class _SearchManageState extends ConsumerState<SearchManage> {
  final TextEditingController input = TextEditingController();

  final columns = ["排序", "标题", "关联话题", "点击量", "创建时间", "操作"];

  AsyncTableController<BeanHot> controller = AsyncTableController<BeanHot>();

  bool isAutoSort = true;

  @override
  void initState() {
    super.initState();
    controller.initialize(columns: columns, future: requestBeanList);

    WidgetsBinding.instance.addPostFrameCallback((_) => onInitSearch());
  }

  @override
  void dispose() {
    super.dispose();
    input.dispose();
    controller.dispose();
  }

  void onInitSearch() async {
    await controller.fetchData();
    ref.read(searchSortProvider.notifier).switchToAuto(isAutoSort);
  }

  void onTapSearch() async {
    controller.fetchData();
  }

  Future<List<BeanHot>> requestBeanList(int page, int limit) async {
    final query = {"name": input.text};

    final response =
        await DioRequest().request(HttpConstant.hotSearchList, query: query);

    final tempList = response["list"] ?? [];
    List<BeanHot> beanList = List<BeanHot>.from(
      tempList.map((x) => BeanHot.fromJson(x)),
    );
    isAutoSort = response["autoOrder"];
    return beanList;
  }

  Future<bool> requestUpdateAutoSort(bool auto) async {
    Toast.showLoading();
    var response = await DioRequest().request(HttpConstant.setHotSearchSort,
        method: DioMethod.POST, data: {"autoOrder": auto});
    Toast.dismissLoading();

    if (response is bool && !response) return false;
    return true;
  }

  Future<void> requestDelete(List<int> ids) async {
    Toast.showLoading();
    var response = await DioRequest().request(HttpConstant.hotSearchDelete,
        method: DioMethod.POST, data: json.encode(ids));
    Toast.dismissLoading();

    if (response is bool && !response) return;
    Toast.showToast("删除成功", true);

    int dataLen = controller.dataLen;
    controller.updateDataLen(dataLen - ids.length);

    controller.fetchData();
  }

  Future<void> requestSaveSort(List<int> ids) async {
    Toast.showLoading();
    var response = await DioRequest().request(HttpConstant.hotSearchSort,
        method: DioMethod.POST, data: json.encode(ids));
    Toast.dismissLoading();

    if (response is bool && !response) return;
    Toast.showToast("排序成功", true);

    controller.fetchData();
  }

  void onAutoChanged(bool auto) async {
    bool success = await requestUpdateAutoSort(auto);
    if (!success) return;

    isAutoSort = success;
    ref.read(searchSortProvider.notifier).switchToAuto(auto);

    if (auto) {
      controller.fetchData();
    }
  }

  void onTapCreate() {
    context.push(RouterPath.path_search_create);
  }

  void onTapEditSort() {
    ref.read(searchSortProvider.notifier).switchSortStatus();

    bool isSort = ref.read(searchSortProvider).isSorting;
    controller.updateToSort(isSort);
  }

  void onTapMultiDel() async {
    if (controller.selection.isEmpty) return Toast.showToast("请先选择热搜");

    bool? confirm = await Toast.showAlert("确定删除热搜？");
    if (confirm == null || !confirm) return;
    List<int> topics = controller.selection.map((x) => x.id).toList();
    await requestDelete(topics);
  }

  void onSaveSort() async {
    bool? confirm = await Toast.showAlert("确定排序？");
    if (confirm == null || !confirm) return;

    List<int> topics = controller.sortList.map((x) => x.id).toList();
    await requestSaveSort(topics);
  }

  void onTapDelete(BeanHot bean) async {
    bool? confirm = await Toast.showAlert("确定删除热搜？");
    if (confirm == null || !confirm) return;

    await requestDelete([bean.id]);
  }

  void onTapEdit(BeanHot bean) {
    context.push(RouterPath.path_search_create, extra: bean);
  }

  void onTapPinned(BeanHot bean) async {
    List<int> topics = controller.dataList.map((x) => x.id).toList();

    topics.remove(bean.id);
    topics.insert(0, bean.id);
    await requestSaveSort(topics);
  }

  ({String key, List<Widget> widgetList}) buildTabRowList(BeanHot bean) {
    List<Widget> beanList = [
      AsyncText("${bean.orderId}"),
      AsyncText(bean.title),
      AsyncText(bean.topicName),
      AsyncText("${bean.clickCnt}"),
      AsyncText(bean.createTime),
      Wrap(alignment: WrapAlignment.center, children: [
        TxtButton("删除", onTap: () => onTapDelete(bean)),
        TxtButton("编辑", onTap: () => onTapEdit(bean)),
        TxtButton("置顶", onTap: () => onTapPinned(bean)),
      ])
    ];

    return (key: "${bean.id}", widgetList: beanList);
  }

  Widget buildFilterDrops() {
    var auto = ref.watch(searchSortProvider);

    return LayoutBuilder(builder: (_, constraint) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        child: SizedBox(
          width: constraint.maxWidth < 1200 ? 1200 : constraint.maxWidth,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: auto.isSorting
                  ? [
                      BorderButton("保存排序", onTap: onSaveSort),
                      const SizedBox(width: 20),
                      BorderButton("取消排序", onTap: onTapEditSort),
                    ]
                  : [
                      SearchSortSwitch(auto.isAuto, onChanged: onAutoChanged),
                      const SizedBox(width: 20),
                      BorderButton("创建", onTap: onTapCreate),
                      if (!auto.isAuto) ...[
                        const SizedBox(width: 20),
                        BorderButton("编辑排序", onTap: onTapEditSort),
                      ],
                      const SizedBox(width: 20),
                      BorderButton("批量删除", onTap: onTapMultiDel),
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
        child: AsyncTable<BeanHot>(ctr: controller, builder: buildTabRowList),
      ),
    ]));
  }
}
