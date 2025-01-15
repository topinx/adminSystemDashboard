import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/select_item.dart';
import 'package:top_back/bean/bean_topic.dart';
import 'package:top_back/contants/app_constants.dart';

import '../controller/topic_create_controller.dart';

class ManageTopicEdit extends StatefulWidget {
  const ManageTopicEdit({super.key, this.topic});

  final BeanTopic? topic;

  @override
  State<ManageTopicEdit> createState() => _ManageTopicEditState();
}

class _ManageTopicEditState extends State<ManageTopicEdit> {
  final TopicCreateController ctr = Get.put(TopicCreateController());

  @override
  void initState() {
    super.initState();
    ctr.topic = widget.topic;
    ctr.status = widget.topic?.status ?? 1;
  }

  void onTapCancel() {
    Navigator.of(context).pop();
  }

  Widget buildCoverContent() {
    return GetBuilder<TopicCreateController>(builder: (ctr) {
      DecorationImage? image;
      if (ctr.dataCover != null) {
        image = DecorationImage(image: MemoryImage(ctr.dataCover!));
      } else if (ctr.topic != null && ctr.topic!.avatar.isNotEmpty) {
        image = DecorationImage(
            image: NetworkImage(AppConstants.imgLink + ctr.topic!.avatar));
      }

      return GestureDetector(
        onTap: ctr.onTapCover,
        child: Container(
          width: 120,
          height: 80,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(color: const Color(0xFFEBEBEB), image: image),
          child: image == null ? const Text("点击上传") : null,
        ),
      );
    });
  }

  Widget buildEditBan() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 60, 20),
      child: GetBuilder<TopicCreateController>(builder: (ctr) {
        return Row(children: [
          const Text("封禁开关："),
          SelectItem("封禁", ctr.status == 0, onTap: ctr.onTapBan),
          const SizedBox(width: 10),
          SelectItem("解除封禁", ctr.status == 1, onTap: ctr.onTapUnban),
        ]);
      }),
    );
  }

  Widget buildEditContent() {
    return Column(children: [
      Row(children: [
        const SizedBox(width: 15),
        Text(widget.topic == null ? "创建话题" : "编辑话题",
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        const Spacer(),
        const CloseButton(),
      ]),
      Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 60, 20),
        height: 35,
        child: Row(children: [
          const Text("话题标题："),
          Expanded(child: TextField(controller: ctr.inputName)),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 60, 20),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("话题封面："),
          buildCoverContent(),
        ]),
      ),
      Visibility(visible: widget.topic != null, child: buildEditBan()),
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 320,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: buildEditContent(),
        ),
      ),
    );
  }
}
