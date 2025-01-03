import 'package:flutter/material.dart';

class TableText extends StatelessWidget {
  const TableText(this.text, this.isTitle,
      {super.key, this.first, this.active});

  final String text;

  final bool isTitle;

  final bool? first;

  final bool? active;

  @override
  Widget build(BuildContext context) {
    IconData iconData = (active ?? false)
        ? Icons.indeterminate_check_box_rounded
        : Icons.check_box_outline_blank;

    return SizedBox(
      height: isTitle ? 60 : 50,
      child: Row(children: [
        if (first ?? false) ...[
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(iconData, color: Colors.black12),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
        Expanded(
            child: Text(text,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis)),
      ]),
    );
  }
}
