import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/pages/mixins/popup_alerts.dart';
import 'package:flutter_app_video_player/pages/shared_widgets/popup_item.dart';
import 'package:flutter_app_video_player/pages/shared_widgets/popup_items.dart';
import 'package:flutter_app_video_player/shared_state/videocontroller/menu_controller_pool.dart';
import 'package:provider/provider.dart';

class VideoPopUpMenuButton extends StatelessWidget
    with SubtitleAlert, AudioAlert {
  static const SPEED_POP_UP_ITMES = 0;
  static const SUBTITLE_POP_UP_ITMES = 1;
  static const AUDIO_POP_UP_ITMES = 2;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
        color: Colors.black87,
        onSelected: (value) {
          selectedAction(value, context);
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                value: SPEED_POP_UP_ITMES,
                child: PopUpSpeedItem(),
              ),
              PopupMenuItem(
                value: SUBTITLE_POP_UP_ITMES,
                child: PopUpItem(Icons.sticky_note_2_rounded, 'Subtitle'),
              ),
              PopupMenuItem(
                value: AUDIO_POP_UP_ITMES,
                child: PopUpItem(Icons.audiotrack_rounded, 'Audio'),
              )
            ]);
  }

  void selectedAction(int value, BuildContext context) async {
    switch (value) {
      case SUBTITLE_POP_UP_ITMES:
        openSubtitle(context, context.read<MenuControllerPool>());
        break;
      case AUDIO_POP_UP_ITMES:
        openAudio(context, context.read<MenuControllerPool>());
        break;
    }
  }
}
