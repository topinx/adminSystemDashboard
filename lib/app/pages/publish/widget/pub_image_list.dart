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
      ImageCell(
        ctr.detail.cover,
        onTapChange: ctr.onTapCover,
        onTapDelete: ctr.onDeleteCover,
      ),
      Container(
        margin: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.add),
      ),
      ...List.generate(
          ctr.detail.materialList.length,
          (i) => ImageCell(
                ctr.detail.materialList[i],
                onTapChange: ctr.onTapMaterial,
                onTapDelete: ctr.onDeleteMaterial,
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
  const ImageCell(this.data,
      {super.key, required this.onTapChange, required this.onTapDelete});

  final DraftMaterial data;

  final Function(DraftMaterial) onTapChange;

  final Function(DraftMaterial) onTapDelete;

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
      onTap: () => onTapChange(data),
      child: Container(
        height: 120,
        width: 120,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFEBEBEB),
          image: decorationImage,
        ),
        alignment: Alignment.center,
        child: Stack(children: [
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => onTapDelete(data),
              child: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                color: Colors.black12,
                child: const Icon(Icons.delete_forever_outlined,
                    color: Colors.redAccent),
              ),
            ),
          ),
          if (data.type == 2)
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black54,
              child: Icon(Icons.play_arrow, color: Colors.white),
            ),
        ]),
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
