import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/pages/mixins/popup_alerts.dart';
import 'package:flutter_app_video_player/pages/shared_widgets/popup_items.dart';
import 'package:flutter_app_video_player/shared_state/providers_exports.dart';

class MenuControllerPool extends ChangeNotifier
    with SubtitleHelper, AudioTrackHelper {
  VideoPlayerPool videoPlayerPool;

  Speed get currentSpeed => videoPlayerPool.currentSpeed;

  MenuControllerPool(VideoPlayerPool videoPlayerPool) {
    this.videoPlayerPool = videoPlayerPool;
  }

  @override
  void setAudioTrack(int audioTrackNumber) async {
    await videoPlayerPool.flickManager.flickVideoManager.videoPlayerController
        .setAudioTrack(audioTrackNumber);
    notifyListeners();
    notifyListeners();
  }

  @override
  void setSubtitleTrack(int subtitleSelectedId) async {
    int currentSubtitle = await videoPlayerPool
        .flickManager.flickVideoManager.videoPlayerController
        .getSpuTrack();
    if (subtitleSelectedId == currentSubtitle) subtitleSelectedId = -1;
    videoPlayerPool.flickManager.flickVideoManager.videoPlayerController
        .setSpuTrack(subtitleSelectedId);
  }
}
