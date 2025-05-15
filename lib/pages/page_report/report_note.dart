import 'package:flutter/material.dart';
import 'package:top_back/pages/widget/page_card.dart';

class ReportNote extends StatefulWidget {
  const ReportNote({super.key});

  @override
  State<ReportNote> createState() => _ReportNoteState();
}

class _ReportNoteState extends State<ReportNote> {
  @override
  Widget build(BuildContext context) {
    return PageCard(view: const Column());
  }
}
