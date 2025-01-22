import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  const Alert({super.key, required this.title, required this.content});

  final String title;

  final String content;

  Widget buildContent(BuildContext context) {
    return Column(children: [
      const Spacer(),
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      const SizedBox(height: 5),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          content,
          style: const TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ),
      const Spacer(),
      Container(color: Theme.of(context).dividerColor, height: 0.1),
      Row(children: [
        const AlertButton(false),
        Container(
            color: Theme.of(context).dividerColor, width: 0.1, height: 48),
        const AlertButton(true),
      ])
    ]);
  }

  @override
  Widget build(BuildContext context) {
    BoxShadow shadow = BoxShadow(
        color: Colors.black.withOpacity(0.1),
        offset: const Offset(1, 1),
        blurRadius: 5,
        spreadRadius: 1);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: 132,
          width: 248,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [shadow],
            borderRadius: BorderRadius.circular(16),
          ),
          child: buildContent(context),
        ),
      ),
    );
  }
}

class AlertButton extends StatelessWidget {
  const AlertButton(this.on, {super.key});

  final bool on;

  @override
  Widget build(BuildContext context) {
    TextStyle? style = TextStyle(
        color: on ? const Color(0xFF3871BB) : Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w600);

    Widget child = Container(
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Text(on ? "确定" : "取消", style: style),
    );

    return Expanded(
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(on);
          },
          child: child),
    );
  }
}
