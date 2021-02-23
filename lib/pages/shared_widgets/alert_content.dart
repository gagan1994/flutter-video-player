import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/config/size.dart';

class PopUpAlertContents extends StatelessWidget {
  Widget child;
  PopUpAlertContents(this.child);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.blueAccent, width: 0.5),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Container(
        color: Colors.transparent,
        height: SizeConfig.screenHeightWithPercentage(50),
        width: SizeConfig.screenWidthWithPercentage(50),
        padding: EdgeInsets.all(10),
        child: child,
      ),
    );
  }
}
