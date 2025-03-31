import 'package:flutter/material.dart';
import 'package:top_back/bean/bean_draft.dart';
import 'package:top_back/contants/app_constants.dart';

import '../controller/publish_controller.dart';

class PubImageList extends StatelessWidget {
  const PubImageList(this.ctr, {super.key});

  final PublishController ctr;

  List<Widget> buildImageList() {
    List<Widget> imageList = [];
    if (ctr.detail.noteType == 1) {
      if (ctr.noteId == 0) {
        List<DraftMaterial> tempList = ctr.detail.materialList;

        imageList = List.generate(
          tempList.length,
          (i) => MaterialItem.img(tempList[i], ctr),
        );

        if (imageList.length < 18) {
          imageList.add(MaterialAdd(ctr));
        }
      } else {
        List<DraftMaterial> tempList = ctr.detail.materialList;

        imageList = List.generate(
          tempList.length,
          (i) => MaterialItem.img(tempList[i], ctr),
        );

        // if (tempList.isNotEmpty &&
        //     ctr.detail.cover.imgLink != tempList.first.imgLink) {
        //   imageList.insert(0, MaterialItem.coverImg(ctr.detail.cover, ctr));
        // }

        if (imageList.length < 18) {
          imageList.add(MaterialAdd(ctr));
        }
      }
    } else {
      imageList.add(MaterialItem.coverVid(ctr.detail.cover, ctr));
      imageList.add(const Icon(Icons.add));
      if (ctr.detail.materialList.isNotEmpty) {
        imageList.add(MaterialItem.vid(ctr.detail.materialList.first, ctr));
      } else {
        imageList.add(MaterialAdd(ctr));
      }
    }

    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 14);
    List<Widget> tempList = buildImageList();

    Widget imageGroup = ListView.separated(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      itemCount: tempList.length,
      separatorBuilder: (_, i) => const SizedBox(width: 20),
      itemBuilder: (_, i) => tempList[i],
    );

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 36,
        width: 80,
        alignment: Alignment.centerLeft,
        child: Text("笔记素材：", style: textStyle),
      ),
      Expanded(child: SizedBox(height: 120, child: imageGroup)),
      const SizedBox(width: 40),
    ]);
  }
}

class MaterialItem extends StatelessWidget {
  final DraftMaterial data;

  final bool isVideo;

  final bool isCover;

  final PublishController ctr;

  const MaterialItem.img(this.data, this.ctr, {super.key})
      : isVideo = false,
        isCover = false;

  const MaterialItem.vid(this.data, this.ctr, {super.key})
      : isVideo = true,
        isCover = false;

  const MaterialItem.coverImg(this.data, this.ctr, {super.key})
      : isVideo = false,
        isCover = true;

  const MaterialItem.coverVid(this.data, this.ctr, {super.key})
      : isVideo = true,
        isCover = true;

  void onTapDelete() {
    ctr.onDeleteMaterial(data);
  }

  void onTapMaterial() {
    if (isCover) {
      ctr.onTapCover(data);
    } else {
      ctr.onTapMaterial(data);
    }
  }

  Widget buildImageContent() {
    if (isVideo && !isCover) {
      if (data.thumbData != null) {
        return Image.memory(data.thumbData!);
      } else if (data.imgThumb.isNotEmpty) {
        return Image.network(
          AppConstants.assetsLink + data.imgThumb,
          headers: {"Authorization": AppConstants.signToken()},
        );
      }
    } else {
      if (data.imgData != null) {
        return Image.memory(data.imgData!);
      } else if (data.imgLink.isNotEmpty) {
        return Image.network(
          AppConstants.assetsLink + data.imgLink,
          headers: {"Authorization": AppConstants.signToken()},
        );
      }
    }

    return const SizedBox();
  }

  Widget buildDeleteIcon() {
    return GestureDetector(
      onTap: onTapDelete,
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        color: Colors.black12,
        child:
            const Icon(Icons.delete_forever_outlined, color: Colors.redAccent),
      ),
    );
  }

  Widget buildContent() {
    return Stack(alignment: Alignment.center, fit: StackFit.expand, children: [
      buildImageContent(),
      if (isVideo && !isCover)
        const Center(
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black54,
            child: Icon(Icons.play_arrow, color: Colors.white),
          ),
        ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapMaterial,
      child: Container(
        height: 120,
        width: 120,
        alignment: Alignment.center,
        decoration: const BoxDecoration(color: Color(0xFFEBEBEB)),
        child: buildContent(),
      ),
    );
  }
}

class MaterialAdd extends StatelessWidget {
  const MaterialAdd(this.ctr, {super.key});

  final PublishController ctr;

  void onTapAdd() {
    ctr.onTapAdd();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapAdd,
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
