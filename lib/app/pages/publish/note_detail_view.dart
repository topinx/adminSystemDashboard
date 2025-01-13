import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/back_app_bar.dart';
import 'package:top_back/app/widgets/view_container.dart';

import 'widget/note_detail_buttons.dart';
import 'widget/note_detail_img.dart';
import 'widget/note_detail_text.dart';

class NoteDetailView extends StatefulWidget {
  const NoteDetailView({super.key});

  @override
  State<NoteDetailView> createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<NoteDetailView> {
  Widget buildViewContent() {
    return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NoteDetailText("笔记图片", ""),
          NoteDetailImg(),
          NoteDetailText("笔记标题", ""),
          NoteDetailText("笔记正文", ""),
          NoteDetailText("笔记话题", ""),
          NoteDetailText("发布者", ""),
          NoteDetailText("审核状态", ""),
          NoteDetailText("推荐状态", ""),
          NoteDetailTendency(),
          SizedBox(height: 80),
          NoteDetailButtons(),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        const BackAppBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: buildViewContent(),
          ),
        )
      ]),
    );
  }
}
