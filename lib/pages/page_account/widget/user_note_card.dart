import 'package:flutter/material.dart';
import 'package:top_back/bean/bean_note.dart';
import 'package:top_back/pages/widget/image.dart';

class UserNoteCard extends StatelessWidget {
  const UserNoteCard(this.bean, {super.key});

  final BeanNote bean;

  Widget buildNoteInfo() {
    return Row(children: [
      NetImage(bean.cover, imgW: 160, imgH: 160),
      const SizedBox(width: 20),
      Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("标题内容：${bean.title}",
                  maxLines: 2, overflow: TextOverflow.ellipsis),
              Text("发布时间：${bean.createTime}"),
            ]),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 420,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: bean.noteId == BigInt.zero ? null : buildNoteInfo(),
    );
  }
}
