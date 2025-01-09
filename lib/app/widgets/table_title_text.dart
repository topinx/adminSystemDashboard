import 'package:flutter/material.dart';

class TableText extends StatelessWidget {
  const TableText(this.text, this.isTitle, {super.key});

  final String text;

  final bool isTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isTitle ? 60 : 50,
      alignment: Alignment.center,
      child: Text(text.isEmpty ? "--" : text,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
    );
  }
}

class TableSelect extends StatelessWidget {
  const TableSelect(this.onTap, this.active, this.activeAll, {super.key});

  final Function() onTap;

  final bool active;

  final bool activeAll;

  @override
  Widget build(BuildContext context) {
    IconData icon = activeAll
        ? Icons.check_box
        : (active
            ? Icons.indeterminate_check_box
            : Icons.check_box_outline_blank);
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon,
            color: activeAll ? const Color(0xFF3871BB) : Colors.black12),
      ),
    );
  }
}
