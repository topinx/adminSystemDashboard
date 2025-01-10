import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/back_app_bar.dart';
import 'package:top_back/app/widgets/view_container.dart';

class NoteDetailView extends StatefulWidget {
  const NoteDetailView({super.key});

  @override
  State<NoteDetailView> createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<NoteDetailView> {
  @override
  Widget build(BuildContext context) {
    return const ViewContainer(
      child: Column(children: [
        BackAppBar(),
      ]),
    );
  }
}
