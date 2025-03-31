import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/preview_dialog.dart';
import 'package:top_back/bean/bean_note_detail.dart';
import 'package:top_back/contants/app_constants.dart';

class NoteDetailImg extends StatelessWidget {
  const NoteDetailImg(this.detail, {super.key});

  final BeanNoteDetail detail;

  void onTapCover() {
    Get.dialog(PreviewDialog(data: detail.cover, type: 1));
  }

  void onTapDetail(BeanNoteMaterial material) {
    Get.dialog(PreviewDialog(data: material.url, type: material.type));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          NoteImage(detail.cover, type: 1, onTap: onTapCover),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.add, color: Colors.black12),
          ),
          ...List.generate(detail.materialList.length, (i) {
            int type = detail.materialList[i].type;
            return NoteImage(
              type == 1
                  ? detail.materialList[i].url
                  : detail.materialList[i].thumb,
              type: type,
              onTap: () => onTapDetail(detail.materialList[i]),
            );
          }),
        ]),
      ),
    );
  }
}

class NoteImage extends StatelessWidget {
  const NoteImage(this.image,
      {super.key, required this.onTap, required this.type});

  final String image;

  final int type;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    DecorationImage? decorationImage;
    if (image.isNotEmpty) {
      decorationImage = DecorationImage(
        image: NetworkImage(
          AppConstants.assetsLink + image,
          headers: {"Authorization": AppConstants.signToken()},
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        width: 120,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFEBEBEB),
          image: decorationImage,
        ),
        alignment: Alignment.center,
        child: type == 2
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
