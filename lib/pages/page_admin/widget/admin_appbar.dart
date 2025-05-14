import 'package:top_back/constants/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:top_back/pages/widget/common_button.dart';
import 'package:top_back/router/router.dart';
import 'package:top_back/toast/toast.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Text(Storage().user.nickname),
        const SizedBox(width: 10),
        CircleAvatar(radius: 16, backgroundColor: Colors.blue),
        const SizedBox(width: 10),
        LoginOutButton(),
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class LoginOutButton extends StatelessWidget {
  const LoginOutButton({super.key});

  void onTapLoginOut() async {
    bool? confirm = await Toast.showAlert("确定退出登录？");
    if (confirm == null || !confirm) return;

    Storage().clearUserInfo();
    router.go(RouterPath.path_login);
  }

  @override
  Widget build(BuildContext context) {
    return ElvButton("退出", warn: true, onTap: onTapLoginOut);
  }
}
