import 'package:flutter_app_video_player/db/moor_database.dart';

import 'providers_exports.dart';
import 'src/aspect_exports.dart';

class FolderPool extends AspectContainer<Folder> with ChildAspect {
  AppDatabase appDatabase;
  FolderPool(this.appDatabase) {
    watchFolder();
  }
  List<FolderData> folderData = [];

  void watchFolder() {
    appDatabase.folderDao.watchAllfolders().listen((event) {
      folderData = event;
      markDirty();
      update();
    });
  }
}
