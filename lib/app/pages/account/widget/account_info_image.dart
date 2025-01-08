import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AccountInfoImage extends StatefulWidget {
  const AccountInfoImage(this.imgType, this.img,
      {super.key, this.enable, required this.onChange});

  final int imgType;

  final String img;

  final bool? enable;

  final Function(String, Uint8List) onChange;

  @override
  State<AccountInfoImage> createState() => _AccountInfoImageState();
}

class _AccountInfoImageState extends State<AccountInfoImage> {
  Uint8List? imageData;
  String imageName = "";

  final ImagePicker imagePicker = ImagePicker();

  @override
  void didUpdateWidget(covariant AccountInfoImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enable != true) {
      imageData = null;
      imageName = "";
    }
  }

  void onTapImage() async {
    if (widget.enable != true) return;

    XFile? file = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: widget.imgType == 1 ? 300 : 600,
      maxHeight: widget.imgType == 1 ? 300 : 800,
      imageQuality: 80,
    );
    if (file == null) return;
    imageName = file.name;
    imageData = await file.readAsBytes();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    DecorationImage? decImage;
    if (widget.enable == true && imageData != null) {
      decImage = DecorationImage(image: MemoryImage(imageData!));
    } else {
      // decImage = DecorationImage(image: NetworkImage(AppConstants.imgLink + widget.img));
    }

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 50,
        width: 60,
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        child: Text(widget.imgType == 1 ? "用户头像" : "背景图"),
      ),
      Container(
        height: 50,
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        child: const Text(":"),
      ),
      GestureDetector(
        onTap: onTapImage,
        child: Container(
          width: 200,
          height: 120,
          margin: const EdgeInsets.only(top: 20, left: 10),
          decoration:
              BoxDecoration(color: const Color(0xFFEBEBEB), image: decImage),
        ),
      ),
    ]);
  }
}
