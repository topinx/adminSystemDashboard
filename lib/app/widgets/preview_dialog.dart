import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_back/contants/app_constants.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';
import 'package:video_player/video_player.dart';

class PreviewDialog extends StatefulWidget {
  const PreviewDialog({super.key, required this.data, this.type});

  final String data;

  final int? type;

  @override
  State<PreviewDialog> createState() => _PreviewDialogState();
}

class _PreviewDialogState extends State<PreviewDialog> with RequestMixin {
  VideoPlayerController? player;
  ChewieController? chewieController;

  @override
  void dispose() {
    super.dispose();
    player?.dispose();
    chewieController?.dispose();
  }

  @override
  void initState() {
    super.initState();
    initVideoPlayer();
  }

  Future<void> initVideoPlayer() async {
    if (widget.type != 2) return;

    String imageLink = await signVideo();
    if (imageLink.isEmpty) return;

    player = VideoPlayerController.networkUrl(Uri.parse(imageLink));
    await player!.initialize();
    player!.addListener(onVideoListener);
    chewieController = ChewieController(
        videoPlayerController: player!, autoPlay: true, showOptions: false);
  }

  void onVideoListener() {
    if (mounted) setState(() {});
  }

  Future<String> signVideo() async {
    String imageLink = "";
    await get(
      HttpConstants.sign,
      param: {"objectName": widget.data},
      success: (data) => imageLink = data,
    );
    return imageLink;
  }

  @override
  Widget build(BuildContext context) {
    Widget? source;
    if (widget.type == 1) {
      source = Center(
        child: Image(image: NetworkImage(AppConstants.imgLink + widget.data)),
      );
    } else if (widget.type == 2) {
      bool isInitialized = player?.value.isInitialized ?? false;
      if (isInitialized) {
        source = AspectRatio(
          aspectRatio: player!.value.aspectRatio,
          child: Material(
            color: Colors.transparent,
            child: Chewie(controller: chewieController!),
          ),
        );
      }
    }

    return Stack(alignment: Alignment.center, children: [
      const Center(child: CupertinoActivityIndicator()),
      if (source != null) source,
    ]);
  }
}
