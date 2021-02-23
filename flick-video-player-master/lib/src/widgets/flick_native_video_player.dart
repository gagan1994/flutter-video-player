import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

/// Renders [VideoPlayer] with [BoxFit] configurations.
class FlickNativeVideoPlayer extends StatelessWidget {
  const FlickNativeVideoPlayer({
    Key key,
    this.fit,
    this.aspectRatioWhenLoading,
    @required this.videoPlayerController,
  }) : super(key: key);

  final BoxFit fit;
  final double aspectRatioWhenLoading;
  final VlcPlayerController videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        double aspectRatio = (size.maxHeight == double.infinity ||
                size.maxWidth == double.infinity)
            ? videoPlayerController?.value?.aspectRatio
            : size.maxWidth / size.maxHeight;
        VlcPlayer videoPlayer = VlcPlayer(
          controller: videoPlayerController,
          aspectRatio: aspectRatio,
        );
        return Container(
          child: videoPlayer,
        );
      },
    );
  }
}
