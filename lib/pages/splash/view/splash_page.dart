import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/config/palette.dart';
import 'package:flutter_app_video_player/config/size.dart';
import 'package:flutter_app_video_player/pages/home/home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:storage_path/storage_path.dart';

import '../../../shared_state/providers_exports.dart';

class SplashPage extends StatefulWidget {
  static const String ROUTE = "splash/";
  const SplashPage();
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    reqPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      body: Container(
          color: Palette.accentColor,
          child: Center(
            child: GestureDetector(
              onTap: () {
                loadVideoPaths();
              },
              child: Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: SizeConfig.screenWidthWithPercentage(40),
              ),
            ),
          )),
    );
  }

  void reqPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    if (statuses[Permission.storage] == PermissionStatus.granted) {
      loadVideoPaths();
    }
  }

  void loadVideoPaths() async {
    var videoPath = await StoragePath.videoPath;
    context.read<Player>().initVideoPaths(videoPath);
    Future.delayed(Duration(seconds: 3));
    await Navigator.pushNamed(context, HomePage.ROUTE);
    Navigator.pop(context);
  }
}
