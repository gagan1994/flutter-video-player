import 'package:flutter_app_video_player/db/moor_database.dart';

import 'providers_exports.dart';
import 'src/aspect_exports.dart';

class VideoPool extends AspectContainer<Videos> with ChildAspect {
  AppDatabase appDatabase;
  int folderId;

  List<FileData> fileList = [];
  VideoPool(this.appDatabase);

  Future<List<FileData>> getFiles() {
    return appDatabase.filesDao.fetchFilesByFolderId(folderId);
  }

  void setFolderId(int folderId) async {
    this.folderId = folderId;
    fileList = await getFiles();
    markDirty();
    update();
  }

  String getThumbnail(String path) {}

  void insertThumbnail(FileData fileData, String thumbnailFile) {
    appDatabase.filesDao.updateThumbnail(fileData, thumbnailFile);
  }
}
