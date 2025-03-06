import 'package:flutter/material.dart';
import 'package:top_back/bean/bean_draft.dart';
import 'package:top_back/contants/app_constants.dart';

import '../controller/publish_controller.dart';

class PubImageList extends StatelessWidget {
  const PubImageList(this.ctr, {super.key});

  final PublishController ctr;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 14);

    List<Widget> imageList = [
      ImageCell(ctr.detail.cover, onTap: ctr.onTapCover),
      Container(
        margin: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.add),
      ),
      ...List.generate(
          ctr.detail.materialList.length,
          (i) => ImageCell(
                ctr.detail.materialList[i],
                onTap: ctr.onTapMaterial,
              )),
      if (ctr.canAddMaterial()) ImageAdd(ctr.onTapAdd),
    ];

    Widget imageGroup = ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        children: imageList);

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 36,
        width: 80,
        alignment: Alignment.centerLeft,
        child: Text("笔记素材：", style: textStyle),
      ),
      Expanded(
        child: SizedBox(height: 120, child: imageGroup),
      ),
      const SizedBox(width: 40),
    ]);
  }
}

class ImageCell extends StatelessWidget {
  const ImageCell(this.data, {super.key, required this.onTap});

  final DraftMaterial data;

  final Function(DraftMaterial) onTap;

  @override
  Widget build(BuildContext context) {
    DecorationImage? decorationImage;
    if (data.type == 1) {
      if (data.imgData != null) {
        decorationImage = DecorationImage(image: MemoryImage(data.imgData!));
      } else if (data.imgLink.isNotEmpty) {
        decorationImage = DecorationImage(
            image: NetworkImage(AppConstants.imgLink + data.imgLink));
      }
    } else {
      if (data.thumbData != null) {
        decorationImage = DecorationImage(image: MemoryImage(data.thumbData!));
      } else if (data.imgThumb.isNotEmpty) {
        decorationImage = DecorationImage(
            image: NetworkImage(AppConstants.imgLink + data.imgThumb));
      }
    }

    return GestureDetector(
      onTap: () => onTap(data),
      child: Container(
        height: 120,
        width: 120,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFEBEBEB),
          image: decorationImage,
        ),
        alignment: Alignment.center,
        child: data.type == 2
            ? const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black54,
                child: Icon(Icons.play_arrow, color: Colors.white),
              )
            : null,
      ),
    );
  }
}

class ImageAdd extends StatelessWidget {
  const ImageAdd(this.onTap, {super.key});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 120,
        margin: const EdgeInsets.only(right: 20),
        color: const Color(0xFFEBEBEB),
        child: const Icon(Icons.add, color: Colors.black12),
      ),
    );
  }
}
