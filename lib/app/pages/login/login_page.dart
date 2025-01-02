import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/login_card.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Widget buildLoginCard(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        height: 360,
        width: 580,
        child: Row(children: [
          Flexible(child: Image.asset("assets/mask.png")),
          Container(width: 1, height: double.infinity, color: Colors.black12),
          const Flexible(child: LoginCard()),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.back,
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: GestureDetector(
          onTap: () {},
          child: Center(child: buildLoginCard(context)),
        ),
      ),
    );
  }
}
