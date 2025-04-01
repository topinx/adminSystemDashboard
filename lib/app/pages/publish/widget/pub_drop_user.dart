import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:top_back/bean/bean_search_user.dart';

import '../controller/publish_controller.dart';

class PubDropUser extends StatefulWidget {
  const PubDropUser(this.ctr, this.controller, {super.key});

  final PublishController ctr;

  final TextEditingController controller;

  @override
  State<PubDropUser> createState() => _PubDropUserState();
}

class _PubDropUserState extends State<PubDropUser> {
  Widget buildOptionsCard(List<BeanSearchUser> options, Function() cancel) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      child: Container(
        width: 180,
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

  Widget buildOptionItem(BeanSearchUser option, Function() cancel) {
    return InkWell(
      onTap: () {
        widget.controller.text = option.nickname;
        widget.ctr.onSelectUser(option);
        cancel();
      },
      child: Ink(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Align(
            alignment: Alignment.centerLeft, child: Text(option.nickname)),
      ),
    );
  }

  void onShowToast(BuildContext inputContext, String string) async {
    if (string.trimRight().isEmpty) {
      widget.ctr.onSelectUser(null);
      return;
    }

    List<BeanSearchUser> options = await widget.ctr.onSubmitUser(string);
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

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 14);

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 36,
        width: 80,
        alignment: Alignment.centerLeft,
        child: Text("发布用户：", style: textStyle),
      ),
      Builder(
        builder: (inputContext) => SizedBox(
          height: 36,
          width: 180,
          child: TextField(
            style: textStyle,
            enabled: widget.ctr.noteId == BigInt.zero,
            controller: widget.controller,
            onSubmitted: (string) => onShowToast(inputContext, string),
            decoration: const InputDecoration(hintText: "输入并查找"),
          ),
        ),
      ),
    ]);
  }
}
