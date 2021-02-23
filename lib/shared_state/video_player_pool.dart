import 'dart:io';

import 'package:flick_video_player/src/manager/flick_manager.dart';
import 'package:flutter_app_video_player/config/Utils.dart';
import 'package:flutter_app_video_player/db/moor_database.dart';
import 'package:flutter_app_video_player/pages/shared_widgets/popup_items.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:screen/screen.dart';

import 'providers_exports.dart';
import 'src/aspect_exports.dart';

class VideoPlayerPool extends AspectContainer<VideoPlayerModel>
    with ChildAspect {
  AppDatabase appDatabase;
  String path;
  Speed currentSpeed = Speed.SPEED_1;
  List<FileData> playList;

  FlickManager flickManager;

  int currentPlayingIndex = -1;

  bool isVolumeVissible = false;
  bool isBrightnessVissible = false;

  double brightness = 0.1;
  double volume = 0;

  VideoPlayerPool(this.appDatabase);

  FileData get currentFile =>
      currentPlayingIndex == -1 ? null : playList[currentPlayingIndex];

  String get totalDuration => getTimeFromDuration(
      flickManager.flickVideoManager.videoPlayerController.value.duration);

  String get displayName => currentFile == null ? "" : currentFile.displayName;

  bool get isInitilized =>
      flickManager == null && playList != null && currentPlayingIndex != -1;

  Future<FileData> _getFile() {
    return appDatabase.filesDao.fetchFileWithPath(path);
  }

  void setFilePath(String path) async {
    flickManager = null;
    this.path = path;
    FileData fileData = await _getFile();
    playList =
        await appDatabase.filesDao.fetchFilesByFolderId(fileData.folderId);
    FileData currentObject =
        playList.firstWhere((element) => element.path == fileData.path);
    if (currentObject == null) {
      return;
    }
    currentPlayingIndex = playList.indexOf(currentObject);

    brightness = await Screen.brightness;
  }

  void insertThumbnail(FileData fileData, String thumbnailFile) {
    appDatabase.filesDao.updateThumbnail(fileData, thumbnailFile);
  }

  void setController(FlickManager flickManager) async {
    this.flickManager = flickManager;
  }

  void fastRewind() {
    flickManager.flickControlManager.seekBackward(Duration(seconds: 10));
  }

  void fastForward() {
    flickManager.flickControlManager.seekForward(Duration(seconds: 10));
  }

  void skipToPreviousVideo() {
    if (hasPreviousVideo()) {
      flickManager.handleChangeVideo(VlcPlayerController.file(
          File(playList[currentPlayingIndex - 1].path)));
      currentPlayingIndex--;
      setController(flickManager);
    }
  }

  void skipToNextVideo() {
    if (hasNextVideo()) {
      flickManager.handleChangeVideo(VlcPlayerController.file(
          File(playList[currentPlayingIndex + 1].path)));
      currentPlayingIndex++;
      setController(flickManager);
    }
  }

  bool hasNextVideo() {
    if (currentPlayingIndex != -1) {
      return currentPlayingIndex < playList.length - 1;
    }
    return false;
  }

  bool hasPreviousVideo() {
    if (currentPlayingIndex != -1) {
      return currentPlayingIndex != 0;
    }
    return false;
  }

  void setSpeed(Speed thisSpeed) async {
    currentSpeed = thisSpeed;
    await flickManager.flickVideoManager.videoPlayerController
        .setPlaybackSpeed(thisSpeed.val);
    double palyBackSpeed = await flickManager
        .flickVideoManager.videoPlayerController
        .getPlaybackSpeed();
    markDirty();
    update();
  }

  void showBrightness() async {
    isBrightnessVissible = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 5));
    isBrightnessVissible = false;
    notifyListeners();
  }

  void setBrightness(double brightness) {
    Screen.setBrightness(brightness);
    this.brightness = brightness;
    showBrightness();
    notifyListeners();
  }

  void showVolume() async {
    isVolumeVissible = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 5));
    isVolumeVissible = false;
    notifyListeners();
  }

  void setVolume(double volume) {
    this.volume = volume;
    flickManager.flickControlManager.setVolume(volume.toInt());
    showVolume();
    notifyListeners();
  }

  void swipeRight(double dx) {
    flickManager.flickControlManager.seekForward(Duration(seconds: dx.toInt()));
  }

  void swipeLeft(double dx) {
    flickManager.flickControlManager
        .seekBackward(Duration(seconds: dx.toInt()));
  }
}
