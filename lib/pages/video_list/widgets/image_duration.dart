import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/config/duration_conv.dart';
import 'package:flutter_app_video_player/config/size.dart';

class ImageDuration extends StatelessWidget {
  String imageUrl;
  String duration;
  ImageDuration({this.imageUrl, this.duration});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: SizeConfig.screenWidthWithPercentage(22),
          height: SizeConfig.screenHeightWithPercentage(6),
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.file(
              File(imageUrl),
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
          ),
        ),
        (duration != null && duration != "")
            ? Positioned(
                bottom: SizeConfig.screenHeightWithPercentage(1),
                right: SizeConfig.screenWidthWithPercentage(2),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: AutoSizeText(
                    DurationConversion.duration(
                        Duration(milliseconds: int.parse(duration))),
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  color: Colors.black,
                ),
              )
            : Container(),
      ],
    );
  }
}
