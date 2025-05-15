import 'package:flutter/material.dart';
import 'package:top_back/pages/widget/page_card.dart';

class ManageEmoji extends StatefulWidget {
  const ManageEmoji({super.key});

  @override
  State<ManageEmoji> createState() => _ManageEmojiState();
}

class _ManageEmojiState extends State<ManageEmoji> {
  @override
  Widget build(BuildContext context) {
    return PageCard(view: const Column());
  }
}
