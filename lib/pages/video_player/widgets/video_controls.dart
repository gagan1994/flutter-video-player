import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/shared_state/providers_exports.dart';
import 'package:provider/provider.dart';

class VideoControls extends StatelessWidget {
  final double iconSize;
  VideoControls(this.iconSize);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            context.read<VideoPlayerPool>().skipToPreviousVideo();
          },
          child: Icon(
            Icons.skip_previous_rounded,
            size: iconSize,
          ),
        ),
        InkWell(
          onTap: () {
            context.read<VideoPlayerPool>().fastRewind();
          },
          child: Icon(
            Icons.fast_rewind_rounded,
            size: iconSize,
          ),
        ),
        FlickPlayToggle(
          size: iconSize,
        ),
        InkWell(
          onTap: () {
            context.read<VideoPlayerPool>().fastForward();
          },
          child: Icon(
            Icons.fast_forward_rounded,
            size: iconSize,
          ),
        ),
        InkWell(
          onTap: () {
            context.read<VideoPlayerPool>().skipToNextVideo();
          },
          child: Icon(
            Icons.skip_next_rounded,
            size: iconSize,
          ),
        ),
      ],
    );
  }
}
