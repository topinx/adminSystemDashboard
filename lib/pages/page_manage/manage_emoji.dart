import 'package:flutter/material.dart';

class ManageEmoji extends StatefulWidget {
  const ManageEmoji({super.key});

  @override
  State<ManageEmoji> createState() => _ManageEmojiState();
}

class _ManageEmojiState extends State<ManageEmoji> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).canvasColor,
      ),
      child: const Column(),
    );
  }
}
