import 'package:flutter/material.dart';
import 'package:top_back/pages/widget/page_card.dart';

class PubCreative extends StatefulWidget {
  const PubCreative({super.key});

  @override
  State<PubCreative> createState() => _PubCreativeState();
}

class _PubCreativeState extends State<PubCreative> {
  @override
  Widget build(BuildContext context) {
    return PageCard(view: const Column());
  }
}
