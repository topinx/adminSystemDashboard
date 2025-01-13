import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/note_drop_filter.dart';

import '../controller/pub_recommend_controller.dart';

class PubRmdFilter extends StatelessWidget {
  const PubRmdFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final PubRecommendController ctr = Get.find<PubRecommendController>();

    Widget content = Row(children: [
      const NoteDropUser(),
      NoteDropFilter(
        NoteDropType.audited,
        onChange: (tag) => ctr.onFilterChange(NoteDropType.audited, tag),
      ),
      NoteDropFilter(
        NoteDropType.recommend,
        onChange: (tag) => ctr.onFilterChange(NoteDropType.audited, tag),
      ),
      NoteDropFilter(
        NoteDropType.type,
        onChange: (tag) => ctr.onFilterChange(NoteDropType.type, tag),
      ),
      NoteDropDate(onChange: ctr.onTimeChange),
    ]);

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        child: content,
      ),
    );
  }
}
