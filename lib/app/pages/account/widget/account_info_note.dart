import 'package:flutter/material.dart';

class AccountInfoNote extends StatelessWidget {
  const AccountInfoNote({super.key});

  Widget buildNoteCover(BuildContext context) {
    return Container(
      height: 120,
      width: 180,
      color: Colors.black12,
    );
  }

  Widget buildNoteInfo(BuildContext context) {
    return const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("标题内容：", maxLines: 2, overflow: TextOverflow.ellipsis),
          Text("阅读量：100"),
          Text("点赞量：100"),
          Text("评论量：100"),
          Text("发布时间：2020-01-01"),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(10),
      width: 480,
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: const Color(0xFFEBEBEB),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        buildNoteCover(context),
        const SizedBox(width: 10),
        Expanded(child: buildNoteInfo(context)),
      ]),
    );
  }
}
