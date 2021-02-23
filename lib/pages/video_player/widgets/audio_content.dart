import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/shared_state/providers_exports.dart';
import 'package:provider/provider.dart';

class AudioContent extends StatelessWidget {
  static const int DISABLE_AUDIO = -1;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<int, String>>(
      future: context.read<VideoPlayerPool>().getAudioTracks(),
      builder: (context, snapshot) {
        if (snapshot == null ||
            snapshot.data == null ||
            snapshot.data.keys.length == 0) {
          return Container(
            margin: EdgeInsets.all(100),
            child: Center(
              child: Text(
                "No Audio Files",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data.keys.length,
                itemBuilder: (context, index) {
                  int item = snapshot.data.keys.elementAt(index);
                  bool isSelected =
                      context.read<VideoPlayerPool>().getActiveAudioTrack() ==
                          snapshot.data.keys.elementAt(index);
                  return ListTile(
                    title: Text(
                      snapshot.data.values.elementAt(index).toString(),
                      style: TextStyle(
                          color: isSelected ? Colors.blue : Colors.white),
                    ),
                    leading: Icon(
                      Icons.audiotrack_rounded,
                      color: isSelected ? Colors.blue : Colors.white,
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
                Navigator.pop(context, DISABLE_AUDIO);
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
