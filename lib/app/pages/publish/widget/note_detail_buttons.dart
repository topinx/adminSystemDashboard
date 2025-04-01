import 'package:flutter/material.dart';

import '../controller/note_detail_controller.dart';

class NoteDetailButtons extends StatelessWidget {
  const NoteDetailButtons(this.ctr, {super.key});

  final NoteDetailController ctr;

  @override
  Widget build(BuildContext context) {
    ButtonStyle style1 = OutlinedButton.styleFrom(
      fixedSize: const Size.fromWidth(100),
      side: const BorderSide(color: Colors.black),
    );

    ButtonStyle style2 = OutlinedButton.styleFrom(
      fixedSize: const Size.fromWidth(100),
      side: const BorderSide(color: Color(0xFF3871BB)),
    );

    return Row(children: [
      if (ctr.noteId == BigInt.zero)
        OutlinedButton(
          onPressed: ctr.onTapPrev,
          style: style1,
          child: const Text("上一篇"),
        ),
      const Spacer(),
      OutlinedButton(
        onPressed: ctr.onTapPass,
        style:
            ctr.detail.auditedStatus == 1 && ctr.detail.recommendedStatus != 1
                ? style2
                : style1,
        child: const Text("审核通过"),
      ),
      const SizedBox(width: 20),
      OutlinedButton(
        onPressed: ctr.onTapUnPass,
        style: ctr.detail.auditedStatus == 2 ? style2 : style1,
        child: const Text("审核不通过"),
      ),
      const SizedBox(width: 20),
      OutlinedButton(
        onPressed: ctr.onTapRecommend,
        style: ctr.detail.recommendedStatus == 1 ? style2 : style1,
        child: const Text("通过并推荐"),
      ),
      const SizedBox(width: 20),
      OutlinedButton(
        onPressed: ctr.onTapViolations,
        style: ctr.detail.auditedStatus == 3 ? style2 : style1,
        child: const Text("违规"),
      ),
      const Spacer(),
      if (ctr.noteId == BigInt.zero)
        OutlinedButton(
          onPressed: ctr.onTapNext,
          style: style1,
          child: const Text("下一篇"),
        ),
    ]);
  }
}
