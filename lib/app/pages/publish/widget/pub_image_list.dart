import 'package:flutter/material.dart';

class PubImageList extends StatelessWidget {
  const PubImageList({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 14);

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 36,
        width: 80,
        alignment: Alignment.centerLeft,
        child: Text("发布用户：", style: textStyle),
      ),
      Expanded(
        child: SizedBox(
          height: 120,
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            children: const [ImageCell(), ImageAdd()],
          ),
        ),
      ),
      const SizedBox(width: 40),
    ]);
  }
}

class ImageCell extends StatelessWidget {
  const ImageCell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      margin: const EdgeInsets.only(right: 20),
      color: const Color(0xFFEBEBEB),
    );
  }
}

class ImageAdd extends StatelessWidget {
  const ImageAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      margin: const EdgeInsets.only(right: 20),
      color: const Color(0xFFEBEBEB),
      child: const Icon(Icons.add),
    );
  }
}
