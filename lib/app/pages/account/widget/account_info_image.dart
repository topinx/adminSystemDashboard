import 'package:flutter/material.dart';
import 'package:top_back/contants/app_constants.dart';

class AccountInfoImage extends StatelessWidget {
  const AccountInfoImage(this.text, this.img, {super.key});

  final String text;

  final String img;

  @override
  Widget build(BuildContext context) {
    DecorationImage? decImage = img.isEmpty
        ? null
        : DecorationImage(image: NetworkImage(AppConstants.imgLink + img));

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 50,
        width: 60,
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        child: Text(text),
      ),
      Container(
        height: 50,
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        child: const Text(":  "),
      ),
      Container(
        width: 200,
        height: 120,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(color: const Color(0xFFEBEBEB), image: null),
      ),
    ]);
  }
}
