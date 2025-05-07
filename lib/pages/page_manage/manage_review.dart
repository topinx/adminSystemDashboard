import 'package:flutter/material.dart';
import 'package:top_back/bean/bean_note.dart';
import 'package:top_back/constants/app_storage.dart';
import 'package:top_back/constants/http_constants.dart';
import 'package:top_back/network/dio_request.dart';
import 'package:top_back/pages/widget/common_button.dart';
import 'package:top_back/pages/widget/filter_drop.dart';
import 'package:top_back/pages/widget/input_search.dart';
import 'package:top_back/pages/widget/table/table_widget.dart';

import 'provider/note_provider.dart';

class ManageReview extends StatefulWidget {
  const ManageReview({super.key});

  @override
  State<ManageReview> createState() => _ManageReviewState();
}

class _ManageReviewState extends State<ManageReview> {
  final TextEditingController input = TextEditingController();

  final stateList1 = ["全部", "未审核", "通过", "未通过", "违规"];
  final stateList2 = ["全部", "不推荐", "推荐"];

  NoteSearchParam param = NoteSearchParam();

  TableController<BeanNote> controller = TableController<BeanNote>();

  final columns = [
    "笔记",
    "标题内容",
    "审核状态",
    "推荐状态",
    "笔记类型",
    "可见范围",
    "发布者",
    "发布时间",
    "操作"
  ];

  @override
  void initState() {
    super.initState();
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
    param.input = input.text;
    onSearch();
  }

  void onSearch() async {
    int dataLen = await requestBeanCount();
    controller.dataLen = dataLen;
    controller.refreshDatasource();
  }

  void onState1Changed(String? string) {
    if (string == null) return;
    int index = stateList1.indexOf(string);
    if (index == -1) return;

    param.auditedStatus = [null, 0, 1, 2, 3][index];
    onSearch();
  }

  void onState2Changed(String? string) {
    if (string == null) return;
    int index = stateList2.indexOf(string);
    if (index == -1) return;

    param.recommendedStatus = [null, 0, 1][index];
    onSearch();
  }

  Future<List<BeanNote>> requestBeanList(int page) async {
    final query = {
      "pageNo": page,
      "limit": 10,
      "beginTime": param.timeBegin,
      "endTime": param.timeEnd,
      "auditedStatus": param.auditedStatus,
      "recommendedStatus": param.recommendedStatus,
      "auditedBy": Storage().user.userId,
    };

    final response =
        await DioRequest().request(HttpConstant.noteList, query: query);

    final tempList = response["list"] ?? [];
    List<BeanNote> beanList = List<BeanNote>.from(
      tempList.map((x) => BeanNote.fromJson(x)),
    );
    return beanList;
  }

  Future<int> requestBeanCount() async {
    final query = {
      "beginTime": param.timeBegin,
      "endTime": param.timeEnd,
      "auditedStatus": param.auditedStatus,
      "recommendedStatus": param.recommendedStatus,
      "auditedBy": Storage().user.userId,
    };

    return await DioRequest().request(HttpConstant.noteCnt, query: query);
  }

  ({String key, List<Widget> widgetList}) buildTabRowList(BeanNote? bean) {
    if (bean == null) {
      return (key: "", widgetList: List.generate(9, (_) => TabPlace()));
    }

    String audited = ["未审核", "通过", "未通过", "违规"][bean.auditedStatus];
    String recommended = bean.recommendedStatus == null
        ? ""
        : ["不推荐", "推荐"][bean.recommendedStatus!];
    String noteType = ["", "图文笔记", "视频笔记"][bean.noteType];
    String status = ["私密", "公开", "好友可见"][bean.status];

    List<Widget> beanList = [
      TabImage(bean.cover),
      TabText(bean.title),
      TabText(audited),
      TabText(recommended),
      TabText(noteType),
      TabText(status),
      TabText(bean.createNickname),
      TabText(bean.createTime),
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
            FilterDrop("审核状态", stateList1[0], (_, __) async => stateList1,
                onChanged: onState1Changed),
            const SizedBox(width: 10),
            FilterDrop("推荐状态", stateList2[0], (_, __) async => stateList2,
                onChanged: onState2Changed),
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
