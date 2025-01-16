import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:top_back/app/widgets/view_container.dart';

import '../account/widget/account_note_input.dart';
import 'controller/search_topic_controller.dart';
import 'widget/search_topic_filter.dart';
import 'widget/search_topic_table.dart';

class SearchTopicView extends StatefulWidget {
  const SearchTopicView({super.key});

  @override
  State<SearchTopicView> createState() => _SearchTopicViewState();
}

class _SearchTopicViewState extends State<SearchTopicView> {
  final SearchTopicController ctr = Get.find<SearchTopicController>();

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        AccountNoteInput(ctr: ctr.inputSearch, onTap: ctr.onTapSearch),
        const SizedBox(height: 40),
        const SearchTopicFilter(),
        const SizedBox(height: 20),
        const Expanded(child: SearchTopicTable()),
      ]),
    );
  }
}
