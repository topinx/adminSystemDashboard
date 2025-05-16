import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_back/bean/bean_hot.dart';
import 'package:top_back/bean/bean_topic.dart';
import 'package:top_back/constants/http_constants.dart';
import 'package:top_back/network/dio_request.dart';
import 'package:top_back/pages/widget/common_button.dart';
import 'package:top_back/toast/toast.dart';

import 'widget/search_edit_input.dart';

class SearchCreate extends StatefulWidget {
  const SearchCreate(this.topic, {super.key});

  final BeanHot? topic;

  @override
  State<SearchCreate> createState() => _SearchCreateState();
}

class _SearchCreateState extends State<SearchCreate> {
  TextEditingController inputTitle = TextEditingController();
  TextEditingController inputSort = TextEditingController();
  TextEditingController inputInter = TextEditingController();

  String get txtTitle => widget.topic == null ? "新建热搜" : "编辑热搜";
  GlobalKey<FormState> formKey = GlobalKey();

  String topicName = "";
  BeanTopic? selectedTopic;

  List<BeanTopic> searchList = [];

  @override
  void initState() {
    super.initState();
    if (widget.topic != null) {
      inputTitle.text = widget.topic!.title;
      inputSort.text = "${widget.topic!.orderId}";
      inputInter.text = widget.topic!.introduction;
      topicName = widget.topic!.topicName;
    }
  }

  @override
  void dispose() {
    super.dispose();
    inputTitle.dispose();
    inputSort.dispose();
    inputInter.dispose();
  }

  void onTapConfirm() {
    bool validate = formKey.currentState?.validate() ?? false;
    if (!validate) return;
  }

  Future<void> requestEdit() async {
    Toast.showLoading();
    var response = await DioRequest().request(
      HttpConstant.updateHotSearch,
      method: DioMethod.POST,
      data: {
        "id": widget.topic!.id,
        "title": inputTitle.text,
        "topicId": widget.topic!.topicId,
        "topicName": widget.topic!.topicName,
        "orderId": int.parse(inputSort.text),
        "introduction": inputInter.text,
      },
    );
    Toast.dismissLoading();

    if (response is bool && !response) return;
    Toast.showToast("修改成功", true);
    context.pop();
  }

  void onTopicChanged(String? string) {
    if (string == null || string.isEmpty) return;

    for (var bean in searchList) {
      if (bean.name == string) {
        selectedTopic = bean;
        return;
      }
    }
  }

  Future<List<String>> requestTopics(String string, _) async {
    var response = await DioRequest().request(
      HttpConstant.topicList,
      query: {"pageNo": 1, "limit": 50, "name": "#$string"},
    );

    if (response is bool && !response) return <String>[];

    List tempList = response["list"] ?? [];
    searchList = tempList.map((x) => BeanTopic.fromJson(x)).toList();

    return List<String>.from(searchList.map((x) => x.name));
  }

  String? onValidatorTopic(String? string) {
    if (string == null || string.isEmpty) return "请输入内容";
    if (widget.topic == null && selectedTopic == null) {
      return "请查询并选择有效的话题";
    }

    return null;
  }

  Widget buildCardContent() {
    return SizedBox(
      width: 300,
      child: Form(
        key: formKey,
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
              Text("热搜标题："),
              const SizedBox(height: 10),
              SearchEditInput.title(inputTitle),
              const SizedBox(height: 20),
              Text("关联话题："),
              const SizedBox(height: 10),
              SearchEditDrop(
                topicName,
                requestTopics,
                enable: widget.topic == null,
                onChanged: onTopicChanged,
                validator: onValidatorTopic,
              ),
              const SizedBox(height: 20),
              Text("热搜排序："),
              const SizedBox(height: 10),
              SearchEditInput.sort(inputSort),
              const SizedBox(height: 20),
              Text("热搜导语："),
              const SizedBox(height: 10),
              SearchEditInput.inter(inputInter),
              const SizedBox(height: 20),
              Center(child: ElvButton("确定", onTap: onTapConfirm)),
            ]),
      ),
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
