import 'package:flutter/material.dart';

class SearchManage extends StatefulWidget {
  const SearchManage({super.key});

  @override
  State<SearchManage> createState() => _SearchManageState();
}

class _SearchManageState extends State<SearchManage> {
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
