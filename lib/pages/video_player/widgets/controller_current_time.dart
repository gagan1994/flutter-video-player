import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/config/Utils.dart';
import 'package:provider/provider.dart';

class ControllerCurrentPosition extends StatelessWidget {
  const ControllerCurrentPosition({
    Key key,
    this.fontSize,
    this.color,
  }) : super(key: key);

  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    FlickVideoManager videoManager = Provider.of<FlickVideoManager>(context);

    Duration position = videoManager?.videoPlayerValue?.position;
    var text = getTimeFromDuration(position);
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}
