import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/shared_state/providers_exports.dart';
import 'package:provider/provider.dart';

class SubtitleContent extends StatelessWidget {
  static const int DISABLE_SUBTITLE = -1;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<int, String>>(
      future: context.read<VideoPlayerPool>().getSpuTracks(),
      builder: (context, snapshot) {
        if (snapshot == null || snapshot.data == null) {
          return Container();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data.keys.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      snapshot.data.values.elementAt(index).toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.note_rounded,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pop(
                        context,
                        snapshot.data.keys.elementAt(index),
                      );
                    },
                  );
                },
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context, DISABLE_SUBTITLE);
              },
              child: Text(
                "Disable",
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        );
      },
    );
  }
}
