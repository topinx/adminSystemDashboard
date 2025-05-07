import 'package:flutter/material.dart';

class ManageClassify extends StatefulWidget {
  const ManageClassify({super.key});

  @override
  State<ManageClassify> createState() => _ManageClassifyState();
}

class _ManageClassifyState extends State<ManageClassify> {
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
