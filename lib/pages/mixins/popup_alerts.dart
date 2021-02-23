import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/pages/shared_widgets/alert_content.dart';
import 'package:flutter_app_video_player/pages/video_player/widgets/audio_content.dart';
import 'package:flutter_app_video_player/pages/video_player/widgets/subtitle_content.dart';

abstract class SubtitleHelper {
  void setSubtitleTrack(int track);
}

abstract class AudioTrackHelper {
  void setAudioTrack(int track);
}

abstract class SubtitleAlert {
  Future<int> openSubtitle(BuildContext context, SubtitleHelper helper) async {
    int subtitleSelected = await showDialog(
      context: context,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(1),
        content: PopUpAlertContents(
          SubtitleContent(),
        ),
      ),
    );
    helper.setSubtitleTrack(subtitleSelected);
    return subtitleSelected;
  }
}

abstract class AudioAlert {
  Future<int> openAudio(BuildContext context, AudioTrackHelper helper) async {
    var audioTrackNumber = await showDialog(
      context: context,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(1),
        content: PopUpAlertContents(
          AudioContent(),
        ),
      ),
    );
    helper.setAudioTrack(audioTrackNumber);
    return audioTrackNumber;
  }
}
