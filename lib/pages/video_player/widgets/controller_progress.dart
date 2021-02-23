import 'package:auto_size_text/auto_size_text.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/shared_state/providers_exports.dart';
import 'package:provider/provider.dart';

import 'controller_current_time.dart';

class ControllerProgress extends StatelessWidget {
  double fontSize;

  ControllerProgress(this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ControllerCurrentPosition(
          fontSize: fontSize,
        ),
        Expanded(
          child: Container(
            child: FlickVideoProgressBar(
              flickProgressBarSettings: FlickProgressBarSettings(
                height: 2.5,
                handleRadius: 5,
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8,
                ),
                backgroundColor: Colors.white24,
                bufferedColor: Colors.white38,
                playedColor: Colors.blue,
                handleColor: Colors.blue,
              ),
            ),
          ),
        ),
        AutoSizeText(context.read<VideoPlayerPool>().totalDuration)
      ],
    );
  }
}
