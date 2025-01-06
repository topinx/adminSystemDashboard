import 'package:flutter/material.dart';

class TableText extends StatelessWidget {
  const TableText(this.text, this.isTitle, {super.key});

  final String text;

  final bool isTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isTitle ? 60 : 50,
      child: Center(
        child: Text(text,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ),
    );
  }
}

class TableSelect extends StatelessWidget {
  const TableSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.check_box_outline_blank, color: Colors.black12),
      ),
    );
  }
}
