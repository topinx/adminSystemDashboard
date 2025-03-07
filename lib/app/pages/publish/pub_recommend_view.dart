import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/note_drop_filter.dart';
import 'package:top_back/app/widgets/page_indicator.dart';
import 'package:top_back/app/widgets/view_container.dart';

import '../account/widget/account_note_input.dart';
import 'controller/pub_recommend_controller.dart';
import 'widget/pub_rmd_filter.dart';
import 'widget/pub_rmd_table.dart';

class PubRecommendView extends StatefulWidget {
  const PubRecommendView({super.key});

  @override
  State<PubRecommendView> createState() => _PubRecommendViewState();
}

class _PubRecommendViewState extends State<PubRecommendView> {
  final PubRecommendController ctr = Get.find<PubRecommendController>();

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        const AccountNoteInput(),
        const SizedBox(height: 40),
        NoteDropPub(onTap: ctr.onTapPublish),
        const SizedBox(height: 20),
        PubRmdFilter(
          onChange: ctr.onFilterChange,
          onTimeChange: ctr.onTimeChange,
          onSubmit: ctr.onSubmitUser,
          onSelect: ctr.onSelectUser,
        ),
        const SizedBox(height: 20),
        const Expanded(child: PubRmdTable()),
        GetBuilder<PubRecommendController>(
          id: "check-page",
          builder: (ctr) => PageIndicator(
            itemCount: ctr.checkCnt,
            onTapPage: ctr.onTapPage,
            curPage: ctr.pageNum,
            onSizeChang: ctr.onPageSizeChanged,
          ),
        ),
      ]),
    );
  }
}
