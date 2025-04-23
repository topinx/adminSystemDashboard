import 'package:top_back/constants/app_storage.dart';
import 'package:flutter/material.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Text(Storage().user.nickname),
        const SizedBox(width: 10),
        CircleAvatar(radius: 16, backgroundColor: Colors.blue),
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
