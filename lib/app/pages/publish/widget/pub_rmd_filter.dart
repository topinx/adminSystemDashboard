import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/note_drop_filter.dart';
import 'package:top_back/bean/bean_search_user.dart';

class PubRmdFilter extends StatelessWidget {
  const PubRmdFilter({
    super.key,
    required this.onSubmit,
    required this.onChange,
    required this.onTimeChange,
    required this.onSelect,
  });

  final Future<List<BeanSearchUser>> Function(String) onSubmit;

  final Function(BeanSearchUser?) onSelect;

  final Function(NoteDropType type, int?) onChange;

  final Function(int, String) onTimeChange;

  @override
  Widget build(BuildContext context) {
    Widget content = Row(children: [
      NoteDropUser(onSubmit, onSelect: onSelect),
      NoteDropFilter(
        NoteDropType.audited,
        onChange: (tag) => onChange(NoteDropType.audited, tag),
      ),
      NoteDropFilter(
        NoteDropType.recommend,
        onChange: (tag) => onChange(NoteDropType.audited, tag),
      ),
      NoteDropFilter(
        NoteDropType.type,
        onChange: (tag) => onChange(NoteDropType.type, tag),
      ),
      NoteDropDate(onChange: onTimeChange),
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
