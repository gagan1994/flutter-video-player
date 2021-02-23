import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/config/palette.dart';

class VideoHomeDrawer extends StatelessWidget {
  List<ListHelper> list = [
    null,
    ListHelper(title: "List", iconData: Icons.list, function: () {}),
    ListHelper(
        title: "Player", iconData: Icons.play_arrow_rounded, function: () {}),
    ListHelper(title: "Decoder", iconData: Icons.settings, function: () {}),
    ListHelper(
        title: "Audio", iconData: Icons.music_note_rounded, function: () {}),
    ListHelper(title: "Subtitle", iconData: Icons.subtitles, function: () {}),
    ListHelper(title: "General", iconData: Icons.note, function: () {}),
    ListHelper(
        title: "Development",
        iconData: Icons.developer_mode_rounded,
        function: () {}),
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (index == 0)
            return DrawerHeader(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.face,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  Center(
                    child: const AutoSizeText(
                      "Login / Signup",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            );
          ListHelper listItem = list[index];
          return ListTile(
            leading: Icon(
              listItem.iconData,
              color: Palette.accentColor,
            ),
            title: AutoSizeText(
              listItem.title,
              style: TextStyle(color: Palette.accentColor),
            ),
            onTap: listItem.function,
          );
        },
      ),
    );
  }
}

class ListHelper {
  IconData iconData;
  String title;
  Function function;
  ListHelper({this.title, this.function, this.iconData});
}
