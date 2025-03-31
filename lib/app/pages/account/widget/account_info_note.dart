import 'package:flutter/material.dart';
import 'package:top_back/bean/bean_note_list.dart';
import 'package:top_back/contants/app_constants.dart';

class AccountInfoNote extends StatelessWidget {
  const AccountInfoNote({super.key, required this.bean});

  final BeanNoteList bean;

  Widget buildNoteCover(BuildContext context, String cover) {
    return Container(
      height: 120,
      width: 180,
      decoration: BoxDecoration(
        color: Colors.black12,
        image: DecorationImage(
          image: NetworkImage(
            AppConstants.assetsLink + cover,
            headers: {"Authorization": AppConstants.signToken()},
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildNoteInfo(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("标题内容：${bean.title}",
              maxLines: 2, overflow: TextOverflow.ellipsis),
          const Text("阅读量：0"),
          const Text("点赞量：0"),
          const Text("评论量：0"),
          Text("发布时间：${bean.createTime}"),
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
        buildNoteCover(context, bean.cover),
        const SizedBox(width: 10),
        Expanded(child: buildNoteInfo(context)),
      ]),
    );
  }
}
