import 'package:flutter/material.dart';

class ViewContainer extends StatelessWidget {
  const ViewContainer({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: child);
  }
}
