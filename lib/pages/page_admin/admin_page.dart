import 'package:flutter/material.dart';

import 'widget/admin_appbar.dart';
import 'widget/admin_drawer.dart';

class AdminPage extends StatefulWidget {
  const AdminPage(this.child, {super.key});

  final Widget child;

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Widget buildViewContent() {
    return Container(
      margin: const EdgeInsets.all(10),
      color: Theme.of(context).canvasColor,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminAppBar(),
      body: Row(children: [
        AdminDrawer(),
        Expanded(child: buildViewContent()),
      ]),
    );
  }
}
