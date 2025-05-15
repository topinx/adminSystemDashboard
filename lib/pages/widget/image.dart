import 'package:flutter/material.dart';
import 'package:top_back/constants/app_constants.dart';
import 'package:top_back/bean/bean_image.dart';

class NetImage extends StatelessWidget {
  const NetImage(this.path, {super.key, this.imgW, this.imgH});

  final String path;

  final double? imgW;

  final double? imgH;

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) return SizedBox(width: imgW, height: imgH);

    return Image.network(
      AppConstants.assetsLink + path,
      headers: {"Authorization": AppConstants.signToken()},
      width: imgW,
      height: imgH,
      errorBuilder: (_, o, s) => Icon(Icons.error_outline),
    );
  }
}

class PickImage extends StatelessWidget {
  const PickImage({
    super.key,
    required this.image,
    required this.onPick,
  });

  final BeanImage image;

  final Function() onPick;

  DecorationImage? buildImage() {
    if (image.imgData != null) {
      return DecorationImage(image: MemoryImage(image.imgData!.bytes));
    }

    if (image.imgLink.isNotEmpty) {
      return DecorationImage(
        image: NetworkImage(AppConstants.assetsLink + image.imgLink,
            headers: {"Authorization": AppConstants.signToken()}),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(4),
          image: buildImage(),
        ),
      ),
    );
  }
}
