import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/config/palette.dart';
import 'package:flutter_app_video_player/config/size.dart';
import 'package:provider/provider.dart';

import '../../../db/moor_database.dart';
import '../../../shared_state/providers_exports.dart';
import '../../video_list/video_list_exports.dart';

class FolderList extends StatelessWidget {
  const FolderList();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: context.watch<FolderPool>().folderData.length,
        itemBuilder: (context, index) {
          FolderData item = context.watch<FolderPool>().folderData[index];
          return ListTile(
            onTap: () {
              print("item clicked: ${item.folderName}");
              Navigator.pushNamed(context, VideoListPage.ROUTE,
                  arguments: item.id);
            },
            title: Row(
              children: [
                Icon(
                  Icons.folder,
                  color: Palette.defaultIconColor,
                  size: SizeConfig.screenHeightWithPercentage(8),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: SizeConfig.screenWidthWithPercentage(70),
                      child: AutoSizeText(
                        item.folderName,
                        style: TextStyle(color: Palette.defaultTextcolor),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AutoSizeText(
                      '${item.count} videos',
                      style: TextStyle(color: Palette.defaultTextcolor),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
