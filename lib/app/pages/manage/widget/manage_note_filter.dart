import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/note_drop_filter.dart';

class ManageNoteFilter extends StatelessWidget {
  const ManageNoteFilter({super.key});

  @override
  Widget build(BuildContext context) {
    Widget content = const Row(children: [
      NoteDropPreferences(),
      NoteDropLimit(),
      NoteDropType(),
      NoteDropStatus(),
      NoteDropDate(),
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
