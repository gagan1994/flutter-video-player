import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/config/palette.dart';
import 'package:flutter_app_video_player/config/size.dart';
import 'package:flutter_app_video_player/pages/video_list/video_list_exports.dart';
import 'package:flutter_app_video_player/shared_state/providers_exports.dart';
import 'package:provider/provider.dart';

import '../../video_player/video_player_exports.dart';

class VideoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Consumer<VideoPool>(
        builder: (context, videoPool, child) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: videoPool.fileList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, LandscapePlayer.ROUTE,
                      arguments: videoPool.fileList[index].path);
                },
                title: Row(
                  children: [
                    Container(
                      width: SizeConfig.screenWidthWithPercentage(22),
                      height: SizeConfig.screenHeightWithPercentage(6),
                      child: ThumbImages(
                        videoPool.fileList[index],
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidthWithPercentage(50),
                      child:
                          AutoSizeText(videoPool.fileList[index].displayName),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.more_vert_rounded,
                          color: Palette.defaultIconColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
