import 'package:flutter/material.dart';
import 'package:top_back/bean/bean_image.dart';
import 'package:top_back/constants/app_constants.dart';

class UserImage extends StatelessWidget {
  const UserImage({
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
