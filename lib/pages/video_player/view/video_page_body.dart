import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_video_player/pages/video_player/widgets/anim_slider_widget.dart';
import 'package:flutter_app_video_player/pages/video_player/widgets/landscape_video_controller.dart';
import 'package:flutter_app_video_player/shared_state/providers_exports.dart';
import 'package:provider/provider.dart';

class VideoPageBody extends StatelessWidget {
  int sensitivity = 8;

  @override
  Widget build(BuildContext context) {
    VideoPlayerPool model = context.read<VideoPlayerPool>();
    return Stack(
      children: [
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            // Note: Sensitivity is integer used when you don't want to mess up vertical drag
            if (details.delta.dx > sensitivity) {
              model.swipeRight(details.delta.dx);
            } else if (details.delta.dx < -sensitivity) {
              model.swipeLeft(details.delta.dx);
            }
          },
          child: Consumer<VideoPlayerPool>(
            builder: (context, model, child) {
              if (model.flickManager == null)
                return Container(
                  color: Colors.black,
                );
              return FlickVideoPlayer(
                flickManager: model.flickManager,
                preferredDeviceOrientation: [
                  DeviceOrientation.landscapeRight,
                  DeviceOrientation.landscapeLeft,
                ],
                systemUIOverlay: [],
                flickVideoWithControls: FlickVideoWithControls(
                  controls: LandscapeVideoController(),
                ),
              );
            },
          ),
        ),
        Positioned(
          left: 0,
          bottom: 100,
          top: 100,
          child: GestureDetector(
            onTap: () {
              model.showBrightness();
            },
            child: Container(
              width: 250,
              height: 100,
              child: AnimSliderWidget(
                model.isBrightnessVissible,
                model.brightness,
                min: 0,
                max: 10,
                activeColor: Colors.orangeAccent,
                onValueChanged: (double b) {
                  model.setBrightness(b);
                },
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 100,
          top: 100,
          child: GestureDetector(
            onTap: () {
              model.showVolume();
            },
            child: Container(
              width: 250,
              height: 100,
              child: AnimSliderWidget(
                model.isVolumeVissible,
                model.volume,
                min: 0,
                max: 100,
                onValueChanged: (double b) {
                  model.setVolume(b);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
