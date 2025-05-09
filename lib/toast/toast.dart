import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:top_back/pages/widget/common.dart';
import 'package:top_back/router/router.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toast {
  static void showToast(String text, [bool success = false]) =>
      toastification.show(
        type: success ? ToastificationType.success : ToastificationType.error,
        style: ToastificationStyle.fillColored,
        animationDuration: const Duration(milliseconds: 300),
        autoCloseDuration: const Duration(seconds: 3),
        showProgressBar: false,
        icon: Icon(success ? Icons.check_circle_outline : Icons.error_outline),
        description: Text(text),
      );

  static OverlayEntry? _entryLoading;

  static void showLoading([bool dismiss = false]) {
    dismissLoading();

    _entryLoading ??=
        OverlayEntry(builder: (_) => LoadingEntry(dismiss: dismiss));
    navigatorKey.currentState?.overlay?.insert(_entryLoading!);
  }

  static void dismissLoading() {
    _entryLoading?.remove();
    _entryLoading = null;
  }

  static Future<bool?> showAlert(String content) async {
    bool? confirm = await showDialog(
        context: navigatorKey.currentContext!, builder: (_) => Alert(content));

    return confirm;
  }
}

class LoadingEntry extends StatelessWidget {
  const LoadingEntry({super.key, this.dismiss = false});

  final bool dismiss;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: dismiss ? Toast.dismissLoading : null,
      child: Container(
        alignment: Alignment.center,
        color: Colors.black38,
        child: const CommonLoading(),
      ),
    );
  }
}

class Alert extends StatelessWidget {
  const Alert(this.content, {super.key});

  final String content;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: SizedBox(height: 40, child: Center(child: Text(content))),
      actions: [
        CupertinoButton(
            onPressed: () => context.pop(true),
            child: Text("确定", style: TextStyle(color: Colors.blue))),
        CupertinoButton(
            onPressed: () => context.pop(false),
            child: Text("取消", style: TextStyle(color: Colors.black))),
      ],
    );
  }
}
