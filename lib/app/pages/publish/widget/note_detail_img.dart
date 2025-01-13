import 'package:flutter/material.dart';

class NoteDetailImg extends StatelessWidget {
  const NoteDetailImg({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 180,
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        child: Row(children: [NoteImage(), NoteImage()]),
      ),
    );
  }
}

class NoteImage extends StatelessWidget {
  const NoteImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 120,
      margin: const EdgeInsets.only(right: 20),
      color: const Color(0xFFEBEBEB),
    );
  }
}
