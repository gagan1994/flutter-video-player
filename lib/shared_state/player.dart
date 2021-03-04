import 'dart:developer';

import '../db/moor_database.dart';
import '../pojoclass/player_model.dart';
import 'providers_exports.dart';
import 'src/aspect_exports.dart';

class Player extends AspectContainer {
  FolderPool _folder;
  VideoPool _videos;
  AppDatabase appDatabase;
  double thumbConversionProgress;
  Player(this.appDatabase)
      : _folder = FolderPool(appDatabase),
        _videos = VideoPool(appDatabase) {
    addAspect(_folder);
    addAspect(_videos);
  }

  FolderPool get folder => _folder;

  VideoPool get videos => _videos;

  void initVideoPaths(String videoPath) async {
    Timeline.startSync("Generate_Thumb");
    PlayerPojo object = PlayerPojo();
    object.fromJson(videoPath);
    for (PlayerModel player in object.playerList) {
      int folderId = await appDatabase.folderDao.insertFolder(FolderData(
          folderName: player.folderName, count: player.files.length));
      for (Files file in player.files) {
        await appDatabase.filesDao.insertFiles(FileData(
          path: file.path,
          folderId: folderId,
          album: file.album ?? "",
          artist: file.artist ?? "",
          dateAdded: file.dateAdded ?? "",
          displayName: file.displayName ?? "",
          duration: file.duration ?? "",
          size: file.size ?? "",
        ));
      }
    }
    Timeline.finishSync();
  }
}
