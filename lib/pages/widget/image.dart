import 'package:flutter/material.dart';
import 'package:top_back/constants/app_constants.dart';

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
    );
  }
}
