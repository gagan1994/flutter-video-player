import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flick_video_player/src/manager/flick_manager.dart';
import 'package:flutter_app_video_player/config/Utils.dart';
import 'package:flutter_app_video_player/db/moor_database.dart';
import 'package:flutter_app_video_player/pages/mixins/popup_alerts.dart';
import 'package:flutter_app_video_player/pages/shared_widgets/popup_items.dart';
import 'package:flutter_app_video_player/shared_state/videocontroller/menu_controller_pool.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:screen/screen.dart';

import 'providers_exports.dart';
import 'src/aspect_exports.dart';

class VideoPlayerPool extends AspectContainer<VideoPlayerModel>
    with ChildAspect, SubtitleHelper, AudioTrackHelper {
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

  MenuControllerPool _menuControllerPool;

  VideoPlayerPool(this.appDatabase, this.path) {
    initContoller();
    _menuControllerPool = MenuControllerPool(this);
  }

  FileData get currentFile =>
      currentPlayingIndex == -1 ? null : playList[currentPlayingIndex];

  String get totalDuration => getTimeFromDuration(
      flickManager.flickVideoManager.videoPlayerController.value.duration);

  String get displayName => currentFile == null ? "" : currentFile.displayName;

  bool get isInitilized =>
      flickManager != null && playList != null && currentPlayingIndex != -1;

  MenuControllerPool get menuController => _menuControllerPool;

  Future<FileData> _getFile() {
    return appDatabase.filesDao.fetchFileWithPath(path);
  }

  void initContoller() async {
    await setFilePath(path);
    VlcPlayerController controller = VlcPlayerController.file(
      File(path),
      hwAcc: HwAcc.FULL,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
    print("controller");
    flickManager = FlickManager(
        videoPlayerController: controller,
        autoInitialize: true,
        autoPlay: true);
    setController(flickManager);
    print("controller");
    notifyListeners();
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
      path = playList[currentPlayingIndex - 1].path;
      initContoller();
      currentPlayingIndex--;
      notifyListeners();
    }
  }

  void skipToNextVideo() {
    if (hasNextVideo()) {
      path = playList[currentPlayingIndex + 1].path;
      initContoller();
      currentPlayingIndex++;
      notifyListeners();
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

  Future<Map<int, String>> getSpuTracks() {
    return flickManager.flickVideoManager.videoPlayerController.getSpuTracks();
  }

  Future<Map<int, String>> getAudioTracks() {
    return flickManager.flickVideoManager.videoPlayerController
        .getAudioTracks();
  }

  int getActiveAudioTrack() {
    return flickManager
        .flickVideoManager.videoPlayerController.value.activeAudioTrack;
  }

  @override
  void setAudioTrack(int audioTrackNumber) async {
    menuController.setAudioTrack(audioTrackNumber);
    notifyListeners();
  }

  @override
  void setSubtitleTrack(int subtitleSelectedId) async {
    menuController.setSubtitleTrack(subtitleSelectedId);
  }
}
