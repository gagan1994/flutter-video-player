import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

import 'controller_bottom.dart';
import 'controller_top.dart';
import 'landscape_play_toggle.dart';

class LandscapeVideoController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FlickShowControlsAction(
          child: FlickSeekVideoAction(
            child: Center(
              child: FlickVideoBuffer(
                child: FlickAutoHideChild(
                  showIfVideoNotInitialized: false,
                  child: LandscapePlayToggle(), //Center widget
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: FlickAutoHideChild(
            child: Column(
              children: <Widget>[
                ControllerTop(),
                Expanded(
                  child: Container(),
                ),
                ControllerBottom(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
//FlickSoundToggle(
//                             size: ICON_SIZE,
//                           ),
