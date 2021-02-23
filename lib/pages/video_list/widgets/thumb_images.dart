import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/db/moor_database.dart';
import 'package:flutter_app_video_player/pages/video_list/widgets/image_duration.dart';
import 'package:flutter_app_video_player/shared_state/video_pool.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbImages extends StatelessWidget {
  FileData item;
  ThumbImages(this.item);

  @override
  Widget build(BuildContext context) {
    print("thumbnailFile ${item.thumbnailFile}");
    return item.thumbnailFile == null
        ? FutureBuilder<String>(
            future: getThumbRequest(context, item.path),
            builder: (context, snapShot) {
              if (snapShot.data == null || snapShot.data == "") {
                return Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator());
              }
              return ImageDuration(
                  imageUrl: snapShot.data, duration: item.duration);
            },
          )
        : ImageDuration(imageUrl: item.thumbnailFile, duration: item.duration);
  }

  Future<String> getThumbRequest(BuildContext context, String path) async {
    print("thumb images updated:");
    var thumbnailFile = await VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 100,
      maxWidth: 100,
      quality: 30,
    );
    print("thumb images updated:dkdfka $thumbnailFile aasas");
    Provider.of<VideoPool>(context, listen: false)
        .insertThumbnail(item, thumbnailFile);
    return thumbnailFile;
  }
}
