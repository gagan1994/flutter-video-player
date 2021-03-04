import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/pages/mixins/popup_alerts.dart';
import 'package:flutter_app_video_player/pages/video_player/widgets/video_popup_menu.dart';
import 'package:flutter_app_video_player/shared_state/providers_exports.dart';
import 'package:provider/provider.dart';

import 'audio_content.dart';

class ControllerTop extends StatelessWidget with AudioAlert {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: Color.fromRGBO(0, 0, 0, 0.4),
      child: Row(
        children: [
          Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: AutoSizeText(
              context.read<VideoPlayerPool>().displayName,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Consumer<VideoPlayerPool>(builder: (context, model, child) {
            return model.getActiveAudioTrack() == null ||
                    model.getActiveAudioTrack() == AudioContent.DISABLE_AUDIO
                ? GestureDetector(
                    onTap: () {
                      openAudio(context, model);
                    },
                    child: Icon(
                      Icons.music_off_rounded,
                      color: Colors.white,
                    ),
                  )
                : Container();
          }),
          ChangeNotifierProvider(
            create: (_) => context.read<VideoPlayerPool>().menuController,
            child: VideoPopUpMenuButton(),
          )
        ],
      ),
    );
  }
}
