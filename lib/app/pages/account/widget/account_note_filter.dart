import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/note_drop_filter.dart';

class AccountNoteFilter extends StatelessWidget {
  const AccountNoteFilter({super.key, required this.onChange});

  final Function(NoteDropType type, int?) onChange;

  @override
  Widget build(BuildContext context) {
    Widget content = Row(children: [
      NoteDropFilter(
        NoteDropType.tendency,
        onChange: (tag) => onChange(NoteDropType.tendency, tag),
      ),
      NoteDropFilter(
        NoteDropType.limit,
        onChange: (tag) => onChange(NoteDropType.limit, tag),
      ),
      NoteDropFilter(
        NoteDropType.type,
        onChange: (tag) => onChange(NoteDropType.type, tag),
      ),
      NoteDropFilter(
        NoteDropType.audited,
        onChange: (tag) => onChange(NoteDropType.audited, tag),
      ),
      NoteDropFilter(
        NoteDropType.recommend,
        onChange: (tag) => onChange(NoteDropType.recommend, tag),
      ),
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
