import 'package:flutter/material.dart';
import 'package:top_back/bean/bean_hot.dart';
import 'package:top_back/constants/http_constants.dart';
import 'package:top_back/network/dio_request.dart';
import 'package:top_back/pages/widget/common_button.dart';
import 'package:top_back/pages/widget/input_search.dart';
import 'package:top_back/pages/widget/page_card.dart';
import 'package:top_back/pages/widget/table/async_table.dart';

class SearchManage extends StatefulWidget {
  const SearchManage({super.key});

  @override
  State<SearchManage> createState() => _SearchManageState();
}

class _SearchManageState extends State<SearchManage> {
  final TextEditingController input = TextEditingController();

  final columns = ["排序", "标题", "关联话题", "点击量", "创建时间", "操作"];

  AsyncTableController<BeanHot> controller = AsyncTableController<BeanHot>();

  @override
  void initState() {
    super.initState();
    controller.initialize(columns: columns, future: requestBeanList);

    WidgetsBinding.instance.addPostFrameCallback((_) => onTapSearch());
  }

  @override
  void dispose() {
    super.dispose();
    input.dispose();
    controller.dispose();
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
    // bool isAutoSort = response["autoOrder"];
    return beanList;
  }

  void onTapCreate() {}

  void onTapEditSort() {}

  void onTapMultiDel() {}

  void onTapDelete(BeanHot bean) {}

  void onTapEdit(BeanHot bean) {}

  void onTapPinned(BeanHot bean) {}

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
    return LayoutBuilder(builder: (_, constraint) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        child: SizedBox(
          width: constraint.maxWidth < 1200 ? 1200 : constraint.maxWidth,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            BorderButton("创建", onTap: onTapCreate),
            const SizedBox(width: 20),
            BorderButton("编辑排序", onTap: onTapEditSort),
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
