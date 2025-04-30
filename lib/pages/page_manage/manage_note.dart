import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_back/bean/bean_note.dart';
import 'package:top_back/pages/widget/common_button.dart';
import 'package:top_back/pages/widget/filter_drop.dart';
import 'package:top_back/pages/widget/input_search.dart';
import 'package:top_back/pages/widget/table/table_widget.dart';

class ManageNote extends ConsumerStatefulWidget {
  const ManageNote({super.key});

  @override
  ConsumerState createState() => _ManageNoteState();
}

class _ManageNoteState extends ConsumerState<ManageNote> {
  final TextEditingController input = TextEditingController();

  final stateList1 = ["全部", "男性", "女性", "综合"];
  final stateList2 = ["全部", "私密", "公开", "仅好友"];
  final stateList3 = ["全部", "图文笔记", "视频笔记"];
  final stateList4 = ["全部", "未审核", "通过", "未通过", "违规"];
  final stateList5 = ["全部", "不推荐", "推荐"];

  final columns = [
    "笔记",
    "标题内容",
    "审核状态",
    "推荐状态",
    "笔记类型",
    "可见范围",
    "审核人",
    "发布时间",
    "操作"
  ];

  TableController<BeanNote> controller = TableController<BeanNote>();

  @override
  void initState() {
    super.initState();
    controller.builder = buildTabRowList;
    controller.future = requestBeanList;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    input.dispose();
  }

  void onState1Changed(String? string) {
    if (string == null) return;
    int index = stateList1.indexOf(string);
    if (index == -1) return;
  }

  Future<List<BeanNote>> requestBeanList(int page) async {
    return [];
  }

  ({String key, List<Widget> widgetList}) buildTabRowList(BeanNote? bean) {
    if (bean == null) {
      return (key: "", widgetList: List.generate(9, (_) => TabPlace()));
    }

    List<Widget> beanList = [
      TabImage(bean.cover),
      TabText(bean.title),
      TabText(bean.title),
      TabText(bean.title),
      TabText(bean.title),
      TabText(bean.title),
      TabText(bean.title),
      TabText(bean.title),
      TxtButton("查看详情")
    ];

    return (key: "${bean.noteId}", widgetList: beanList);
  }

  Widget buildFilterDrops() {
    return LayoutBuilder(builder: (_, constraint) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        child: SizedBox(
          width: constraint.maxWidth < 1200 ? 1200 : constraint.maxWidth,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            FilterDrop("笔记偏好", stateList1[0], (_, __) async => stateList1,
                onChanged: onState1Changed),
            const SizedBox(width: 10),
            FilterDrop("可见范围", stateList2[0], (_, __) async => stateList2,
                onChanged: onState1Changed),
            const SizedBox(width: 10),
            FilterDrop("笔记类型", stateList3[0], (_, __) async => stateList3,
                onChanged: onState1Changed),
            const SizedBox(width: 10),
            FilterDrop("审核状态", stateList4[0], (_, __) async => stateList4,
                onChanged: onState1Changed),
            const SizedBox(width: 10),
            FilterDrop("推荐状态", stateList5[0], (_, __) async => stateList5,
                onChanged: onState1Changed),
          ]),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InputSearch(input),
      const SizedBox(height: 50),
      buildFilterDrops(),
      const SizedBox(height: 20),
      // Expanded(
      //   child: TableWidget(
      //     columns: columns,
      //     controller: controller,
      //   ),
      // ),
    ]);
  }
}
