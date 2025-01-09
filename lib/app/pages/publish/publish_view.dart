import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/view_container.dart';

import '../account/widget/account_note_bar.dart';
import 'widget/pub_drop_user.dart';
import 'widget/pub_image_list.dart';

class PublishView extends StatefulWidget {
  const PublishView({super.key});

  @override
  State<PublishView> createState() => _PublishViewState();
}

class _PublishViewState extends State<PublishView> {
  @override
  Widget build(BuildContext context) {
    return const ViewContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AccountNoteBar(),
        SizedBox(height: 40),
        Text(
          "发布信息",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        SizedBox(height: 20),
        PubDropUser(),
        SizedBox(height: 40),
        Text(
          "笔记信息",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        SizedBox(height: 20),
        PubImageList(),
      ]),
    );
  }
}
