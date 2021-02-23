import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/pages/video_player/widgets/controller_progress.dart';
import 'package:flutter_app_video_player/pages/video_player/widgets/video_controls.dart';

class ControllerBottom extends StatelessWidget {
  final double iconSize;
  final double fontSize;

  const ControllerBottom({Key key, this.iconSize = 30, this.fontSize = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: Color.fromRGBO(0, 0, 0, 0.4),
      child: Column(
        children: [
          ControllerProgress(fontSize),
          SizedBox(
            height: 10,
          ),
          VideoControls(iconSize),
        ],
      ),
    );
  }
}
