import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/view_container.dart';

import 'controller/note_detail_controller.dart';
import 'widget/note_detail_buttons.dart';
import 'widget/note_detail_img.dart';
import 'widget/note_detail_text.dart';
import 'widget/pub_detail_bar.dart';

class NoteDetailView extends StatefulWidget {
  const NoteDetailView({super.key});

  @override
  State<NoteDetailView> createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<NoteDetailView> {
  final NoteDetailController ctr = Get.find<NoteDetailController>();

  Widget buildViewContent() {
    return GetBuilder<NoteDetailController>(builder: (ctr) {
      String audited = ["未审核", "通过", "未通过", "违规"][ctr.detail.auditedStatus];
      String recommended = ctr.detail.recommendedStatus == null
          ? ""
          : ["不推荐", "推荐"][ctr.detail.recommendedStatus!];

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const NoteDetailText("笔记图片", "(封面) + 资源列表"),
        NoteDetailImg(ctr.detail),
        NoteDetailText("笔记标题", ctr.detail.title),
        NoteDetailText("笔记正文", ctr.getContent()),
        NoteDetailText("笔记话题", ctr.getTopicList()),
        NoteDetailText("发布者ID", "${ctr.detail.createBy}"),
        NoteDetailText("发布者", ctr.detail.createByNickname),
        NoteDetailText("审核者", ctr.detail.auditedNickname),
        NoteDetailText("审核状态", audited),
        NoteDetailText("推荐状态", recommended),
        NoteDetailTendency(ctr.detail, onTap: ctr.onTapTendency),
        const SizedBox(height: 80),
        if (ctr.curNote != BigInt.zero) NoteDetailButtons(ctr),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        const PubDetailBar(),
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
