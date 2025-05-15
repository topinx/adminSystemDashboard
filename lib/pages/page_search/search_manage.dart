import 'package:flutter/material.dart';
import 'package:top_back/pages/widget/page_card.dart';

class SearchManage extends StatefulWidget {
  const SearchManage({super.key});

  @override
  State<SearchManage> createState() => _SearchManageState();
}

class _SearchManageState extends State<SearchManage> {
  @override
  Widget build(BuildContext context) {
    return PageCard(view: const Column());
  }
}
