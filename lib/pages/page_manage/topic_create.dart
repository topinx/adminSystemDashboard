import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_back/bean/bean_image.dart';
import 'package:top_back/bean/bean_topic.dart';
import 'package:top_back/constants/http_constants.dart';
import 'package:top_back/network/dio_request.dart';
import 'package:top_back/pages/widget/common_button.dart';
import 'package:top_back/pages/widget/image.dart';
import 'package:top_back/toast/toast.dart';
import 'package:top_back/util/utils.dart';

import 'widget/input_topic.dart';

class TopicCreate extends StatefulWidget {
  const TopicCreate(this.topic, {super.key});

  final BeanTopic? topic;

  @override
  State<TopicCreate> createState() => _TopicCreateState();
}

class _TopicCreateState extends State<TopicCreate> {
  TextEditingController input = TextEditingController();
  BeanImage cover = BeanImage("", null);

  String get txtTitle => widget.topic == null ? "创建话题" : "编辑话题";

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.topic != null) {
      input.text = widget.topic!.name.replaceFirst("#", "").trimRight();
      cover = BeanImage(widget.topic!.avatar, null);
    }
  }

  @override
  void dispose() {
    super.dispose();
    input.dispose();
  }

  void onPickCover() async {
    List<XMLImage> files = await Utils.pickFile();
    if (files.isEmpty) return;

    cover = BeanImage("", files.first);
    if (mounted) setState(() {});
  }

  void onTapConfirm() {
    bool validate = formKey.currentState?.validate() ?? false;
    if (!validate) return;

    if (widget.topic == null) {
      if (cover.imgData == null) {
        Toast.showToast("请设置话题封面");
        return;
      }

      requestCreate();
    } else {
      requestEdit();
    }
  }

  Future<void> requestCreate() async {
    Toast.showLoading();

    String objectName = Utils.objectName("topic", cover.imgData!.name);
    cover.imgLink = await DioRequest().upload(cover.imgData!.bytes, objectName);

    if (cover.imgLink.isEmpty) {
      Toast.showToast("话题封面上传失败");
      return;
    }

    String topic = input.text;
    topic = topic.trimRight() + " ";
    topic = "#$topic";

    var response = await DioRequest().request(
      HttpConstant.topicCreate,
      method: DioMethod.POST,
      data: {"name": topic, "avatar": cover.imgLink},
    );
    Toast.dismissLoading();

    if (response is bool && !response) return;
    Toast.showToast("创建成功", true);
    context.pop();
  }

  Future<void> requestEdit() async {
    Toast.showLoading();

    String topic = input.text;
    topic = topic.trimRight() + " ";
    topic = "#$topic";

    if (cover.imgData != null) {
      String objectName = Utils.objectName("topic", cover.imgData!.name);
      cover.imgLink =
          await DioRequest().upload(cover.imgData!.bytes, objectName);

      if (cover.imgLink.isEmpty) {
        Toast.showToast("话题封面上传失败");
        return;
      }
    }

    var response = await DioRequest().request(
      HttpConstant.topicEdit,
      method: DioMethod.POST,
      data: {
        "id": widget.topic!.id,
        "name": topic,
        "status": widget.topic!.status,
        "avatar": cover.imgLink
      },
    );
    Toast.dismissLoading();

    if (response is bool && !response) return;
    Toast.showToast("修改成功", true);
    context.pop();
  }

  Widget buildCardContent() {
    return SizedBox(
      width: 300,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                txtTitle,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),
            Text("话题标题："),
            const SizedBox(height: 10),
            Form(key: formKey, child: InputTopic(input: input)),
            const SizedBox(height: 20),
            Text("话题封面："),
            const SizedBox(height: 10),
            PickImage(image: cover, onPick: onPickCover),
            const SizedBox(height: 20),
            Center(child: ElvButton("确定", onTap: onTapConfirm)),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
          child: buildCardContent(),
        ),
      ),
    );
  }
}
