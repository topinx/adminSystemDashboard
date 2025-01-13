import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/back_app_bar.dart';
import 'package:top_back/app/widgets/view_container.dart';

import 'controller/publish_controller.dart';
import 'widget/pub_drop_user.dart';
import 'widget/pub_image_list.dart';
import 'widget/pub_input_field.dart';
import 'widget/pub_note_tendency.dart';

class PublishView extends StatefulWidget {
  const PublishView({super.key});

  @override
  State<PublishView> createState() => _PublishViewState();
}

class _PublishViewState extends State<PublishView> {
  final PublishController ctr = Get.find<PublishController>();

  Widget buildPublishContent() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "发布信息",
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
      ),
      const SizedBox(height: 20),
      const PubDropUser(),
      const SizedBox(height: 40),
      const Text(
        "笔记信息",
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
      ),
      const SizedBox(height: 20),
      const PubImageList(),
      const SizedBox(height: 20),
      const PubInputTitle(),
      const SizedBox(height: 20),
      const PubInputContent(),
      const SizedBox(height: 20),
      const PubInputTopic(),
      const SizedBox(height: 20),
      const PubInputOpen(),
      const SizedBox(height: 20),
      const PubNoteTendency(),
      const SizedBox(height: 20),
      buildButtons(),
    ]);
  }

  Widget buildButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      OutlinedButton(onPressed: () {}, child: const Text("确定")),
      const SizedBox(width: 40),
      OutlinedButton(onPressed: Get.back, child: const Text("取消")),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const BackAppBar(),
        Expanded(child: SingleChildScrollView(child: buildPublishContent())),
      ]),
    );
  }
}
