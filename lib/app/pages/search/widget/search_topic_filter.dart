import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/search_topic_controller.dart';

class SearchTopicFilter extends StatelessWidget {
  const SearchTopicFilter({super.key});

  @override
  Widget build(BuildContext context) {
    ButtonStyle style =
        OutlinedButton.styleFrom(fixedSize: const Size.fromWidth(100));

    TextStyle textStyle = const TextStyle(fontSize: 14, color: Colors.black);

    Widget content = GetBuilder<SearchTopicController>(
      id: "search-filter",
      builder: (ctr) => Row(
          children: ctr.isEditSort
              ? [
                  OutlinedButton(
                      style: style,
                      onPressed: ctr.onTapSaveEdit,
                      child: const Text("保存排序")),
                  const SizedBox(width: 30),
                  OutlinedButton(
                      style: style,
                      onPressed: ctr.onTapCancelEdit,
                      child: const Text("取消排序")),
                ]
              : [
                  Text("自动排序：", style: textStyle),
                  SizedBox(
                    height: 25,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: CupertinoSwitch(
                        onChanged: ctr.onChangeAutoSort,
                        value: ctr.isAutoSort,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  OutlinedButton(
                      style: style,
                      onPressed: ctr.onTapCreate,
                      child: const Text("创建")),
                  const SizedBox(width: 30),
                  OutlinedButton(
                      style: style,
                      onPressed: ctr.onTapEditSort,
                      child: const Text("编辑排序")),
                  const SizedBox(width: 30),
                  OutlinedButton(
                      style: style,
                      onPressed: ctr.onTapMultiDelete,
                      child: const Text("批量删除")),
                ]),
    );

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        child: content,
      ),
    );
  }
}
