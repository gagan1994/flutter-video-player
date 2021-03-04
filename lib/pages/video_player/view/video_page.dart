import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_video_player/pages/video_player/view/video_page_body.dart';
import 'package:flutter_app_video_player/shared_state/player.dart';
import 'package:flutter_app_video_player/shared_state/video_player_pool.dart';
import 'package:provider/provider.dart';

class LandscapePlayer extends StatefulWidget {
  static const String ROUTE = "/video_player";
  @override
  _LandscapePlayerState createState() => _LandscapePlayerState();
}

class _LandscapePlayerState extends State<LandscapePlayer> {
  VideoPlayerPool model;

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      model = VideoPlayerPool(context.read<Player>().appDatabase,
          ModalRoute.of(context).settings.arguments);
    }
    return ChangeNotifierProvider(
      create: (_) => model,
      child: Scaffold(
        body: model.isInitilized ? Container() : VideoPageBody(),
      ),
    );
  }

  void updateVideoPath(String path) {
    // this.path = path;
    // initContoller();
  }
}
