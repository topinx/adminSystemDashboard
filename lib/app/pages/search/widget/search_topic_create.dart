import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:top_back/bean/bean_topic.dart';

import '../controller/search_topic_create_controller.dart';

class SearchTopicCreate extends StatefulWidget {
  const SearchTopicCreate({super.key, this.id});

  final int? id;

  @override
  State<SearchTopicCreate> createState() => _SearchTopicCreateState();
}

class _SearchTopicCreateState extends State<SearchTopicCreate> {
  final SearchTopicCreateController ctr =
      Get.put(SearchTopicCreateController());

  @override
  void initState() {
    super.initState();
    ctr.searchId = widget.id ?? 0;
  }

  Widget buildOptionsCard(List<BeanTopic> options, Function() cancel) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      child: Container(
        width: 275,
        constraints: const BoxConstraints(minHeight: 50, maxHeight: 240),
        child: SingleChildScrollView(
            child: Column(children: [
          ...List.generate(
            options.length,
            (i) => buildOptionItem(options[i], cancel),
          ),
        ])),
      ),
    );
  }

  Widget buildOptionItem(BeanTopic option, Function() cancel) {
    return InkWell(
      onTap: () {
        ctr.inputTopic.text = option.name;
        ctr.onSelectTopic(option);
        cancel();
      },
      child: Ink(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Align(alignment: Alignment.centerLeft, child: Text(option.name)),
      ),
    );
  }

  void onShowToast(BuildContext inputContext, String string) async {
    if (string.trimRight().isEmpty) {
      ctr.onSelectTopic(null);
      return;
    }

    List<BeanTopic> options = await ctr.onSubmitSearch(string);
    if (options.isEmpty) {
      BotToast.showText(text: "未搜索到结果", align: Alignment.topCenter);
      return;
    }

    if (!inputContext.mounted) return;
    BotToast.showAttachedWidget(
      attachedBuilder: (cancel) => buildOptionsCard(options, cancel),
      targetContext: inputContext,
      onlyOne: true,
      horizontalOffset: 40.0,
      preferDirection: PreferDirection.bottomCenter,
      enableSafeArea: true,
      allowClick: true,
      animationDuration: const Duration(milliseconds: 350),
      animationReverseDuration: const Duration(milliseconds: 350),
    );
  }

  Widget buildTitleContent() {
    TextStyle style = const TextStyle(fontSize: 14, color: Color(0xFFEBEBEB));
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 60, 20),
      height: 35,
      child: Row(children: [
        const Text("热搜标题："),
        Expanded(
          child: TextField(
            controller: ctr.inputTitle,
            decoration: InputDecoration(hintText: "请输入热搜标题", hintStyle: style),
          ),
        ),
      ]),
    );
  }

  Widget buildTopicContent() {
    TextStyle style = const TextStyle(fontSize: 14, color: Color(0xFFEBEBEB));

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 60, 20),
      height: 35,
      child: Row(children: [
        const Text("关联话题："),
        Expanded(
          child: Builder(
            builder: (inputContext) => TextField(
              controller: ctr.inputTopic,
              onSubmitted: (string) => onShowToast(inputContext, string),
              decoration:
                  InputDecoration(hintText: "输入并查找已创建的话题", hintStyle: style),
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildSortContent() {
    TextStyle style = const TextStyle(fontSize: 14, color: Color(0xFFEBEBEB));

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 60, 20),
      height: 35,
      child: Row(children: [
        const Text("设置排序："),
        Expanded(
          child: TextField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: ctr.inputOrder,
            decoration:
                InputDecoration(hintText: "可输入大于0的整数设置热搜排序", hintStyle: style),
          ),
        ),
      ]),
    );
  }

  Widget buildDescribeContent() {
    TextStyle style = const TextStyle(fontSize: 14, color: Color(0xFFEBEBEB));

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 60, 20),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 35,
          alignment: Alignment.centerLeft,
          child: const Text("热搜导语："),
        ),
        Expanded(
          child: TextField(
            controller: ctr.inputDescr,
            maxLines: 3,
            minLines: 3,
            maxLength: 500,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: "请输入热搜导语",
              hintStyle: style,
              counterText: "",
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildCreateContent() {
    return Column(children: [
      Row(children: [
        const SizedBox(width: 15),
        Text(ctr.searchId == 0 ? "新建热搜" : "编辑话题",
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        const Spacer(),
        const CloseButton(),
      ]),
      buildTitleContent(),
      buildTopicContent(),
      buildSortContent(),
      buildDescribeContent(),
      const Spacer(),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        OutlinedButton(onPressed: onTapCancel, child: const Text("取消")),
        const SizedBox(width: 10),
        OutlinedButton(
            onPressed: () async {
              bool success = await ctr.onTapConfirm();
              if (success) onTapCancel();
            },
            child: const Text("确定")),
        const SizedBox(width: 20)
      ]),
      const SizedBox(height: 20),
    ]);
  }

  void onTapCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 390,
          width: 430,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: buildCreateContent(),
        ),
      ),
    );
  }
}
