import 'package:flutter/material.dart';

class HomeDrawerLogo extends StatelessWidget {
  const HomeDrawerLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      color: const Color(0xFF4C93FB).withOpacity(0.1),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset("assets/logo.png", width: 30, height: 30),
        const SizedBox(width: 10),
        const Text(
          "Top Backstage",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ]),
    );
  }
}
