import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_back/contants/app_constants.dart';
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

    player = VideoPlayerController.networkUrl(
      Uri.parse(AppConstants.assetsLink + widget.data),
      httpHeaders: {"Authorization": AppConstants.signToken()},
    );
    await player!.initialize();
    player!.addListener(onVideoListener);
    chewieController = ChewieController(
        videoPlayerController: player!, autoPlay: true, showOptions: false);
  }

  void onVideoListener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget? source;
    if (widget.type == 1) {
      source = Center(
        child: Image(
          image: NetworkImage(
            AppConstants.assetsLink + widget.data,
            headers: {"Authorization": AppConstants.signToken()},
          ),
        ),
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
