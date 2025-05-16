import 'package:flutter/material.dart';

class PageCard extends StatelessWidget {
  const PageCard({super.key, required this.view});

  final Widget view;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      padding: const EdgeInsets.fromLTRB(16, 25, 16, 10),
      child: view,
    );
  }
}
