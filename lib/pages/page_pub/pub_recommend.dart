import 'package:flutter/material.dart';

class PubRecommend extends StatefulWidget {
  const PubRecommend({super.key});

  @override
  State<PubRecommend> createState() => _PubRecommendState();
}

class _PubRecommendState extends State<PubRecommend> {
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
