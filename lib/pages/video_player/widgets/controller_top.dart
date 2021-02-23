import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/pages/shared_widgets/popup_items.dart';
import 'package:flutter_app_video_player/shared_state/providers_exports.dart';
import 'package:provider/provider.dart';

class ControllerTop extends StatelessWidget {
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
          myPopMenu()
        ],
      ),
    );
  }

  Widget myPopMenu() {
    return PopupMenuButton(
        color: Colors.black87,
        onSelected: (value) {
          print("Selected value is: $value");
        },
        itemBuilder: (context) => [
              PopupMenuItem(value: 2, child: PopUpSpeedItem()),
              PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.add_circle),
                      ),
                      Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )),
            ]);
  }
}
