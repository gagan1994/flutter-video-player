import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_video_player/pages/video_player/widgets/anim_slider_widget.dart';
import 'package:flutter_app_video_player/shared_state/video_player_pool.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../widgets/landscape_video_controller.dart';

class LandscapePlayer extends StatefulWidget {
  static const String ROUTE = "/video_player";
  @override
  _LandscapePlayerState createState() => _LandscapePlayerState();
}

class _LandscapePlayerState extends State<LandscapePlayer> {
  String path;
  FlickManager flickManager;

  int sensitivity = 8;

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    updatePath(context);
    return Scaffold(
      body: Consumer<VideoPlayerPool>(
        builder: (context, model, child) {
          if (model.flickManager == null || model.playList == null) {
            return Container();
          }
          flickManager = model.flickManager;
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
                child: FlickVideoPlayer(
                  flickManager: flickManager,
                  preferredDeviceOrientation: [
                    DeviceOrientation.landscapeRight,
                    DeviceOrientation.landscapeLeft
                  ],
                  systemUIOverlay: [],
                  flickVideoWithControls: FlickVideoWithControls(
                    controls: LandscapeVideoController(),
                  ),
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
                        context.read<VideoPlayerPool>().setBrightness(b);
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
                      onValueChanged: (double b) {
                        context.read<VideoPlayerPool>().setVolume(b);
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void updatePath(BuildContext context) {
    if (path == null) {
      path = ModalRoute.of(context).settings.arguments;
      context.read<VideoPlayerPool>().setFilePath(path);
      initContoller();
    }
  }

  void initContoller() {
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.file(File(path)));
    context.read<VideoPlayerPool>().setController(flickManager);
  }
}
