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

class TableCheckInfo extends StatelessWidget {
  const TableCheckInfo(this.onTap, {super.key});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onTap,
        child: const Text("查看详情", style: TextStyle(color: Color(0xFF3871BB))),
      ),
    );
  }
}

class TableNoteOperate extends StatelessWidget {
  const TableNoteOperate({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
          width: 140,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(
              onPressed: () {},
              child:
                  const Text("推荐", style: TextStyle(color: Color(0xFF3871BB))),
            ),
            TextButton(
              onPressed: () {},
              child:
                  const Text("违规", style: TextStyle(color: Color(0xFF3871BB))),
            ),
          ])),
    );
  }
}
