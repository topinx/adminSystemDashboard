import 'package:flutter/material.dart';

class ReportNote extends StatefulWidget {
  const ReportNote({super.key});

  @override
  State<ReportNote> createState() => _ReportNoteState();
}

class _ReportNoteState extends State<ReportNote> {
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
