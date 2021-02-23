import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_video_player/pages/video_player/widgets/anim_slider_widget.dart';
import 'package:flutter_app_video_player/shared_state/video_player_pool.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:provider/provider.dart';

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
          return _getBody(model);
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

  void initContoller() async {
    VlcPlayerController controller = VlcPlayerController.file(
      File(path),
      hwAcc: HwAcc.FULL,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
    flickManager = FlickManager(
        videoPlayerController: controller,
        autoInitialize: true,
        autoPlay: true);
    context.read<VideoPlayerPool>().setController(flickManager);
    setState(() {});
  }

  Widget _getBody(VideoPlayerPool model) {
    if (model.isInitilized) {
      return Container();
    }
    flickManager = context.read<VideoPlayerPool>().flickManager;
    return Stack(
      children: [
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            // Note: Sensitivity is integer used when you don't want to mess up vertical drag
            if (details.delta.dx > sensitivity) {
              context.read<VideoPlayerPool>().swipeRight(details.delta.dx);
            } else if (details.delta.dx < -sensitivity) {
              context.read<VideoPlayerPool>().swipeLeft(details.delta.dx);
            }
          },
          child: FlickVideoPlayer(
            flickManager: flickManager,
            preferredDeviceOrientation: [
              DeviceOrientation.landscapeRight,
              DeviceOrientation.landscapeLeft,
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
              context.read<VideoPlayerPool>().showBrightness();
            },
            child: Container(
              width: 250,
              height: 100,
              child: AnimSliderWidget(
                context.read<VideoPlayerPool>().isBrightnessVissible,
                context.read<VideoPlayerPool>().brightness,
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
              context.read<VideoPlayerPool>().showVolume();
            },
            child: Container(
              width: 250,
              height: 100,
              child: AnimSliderWidget(
                context.read<VideoPlayerPool>().isVolumeVissible,
                context.read<VideoPlayerPool>().volume,
                min: 0,
                max: 100,
                onValueChanged: (double b) {
                  context.read<VideoPlayerPool>().setVolume(b);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
