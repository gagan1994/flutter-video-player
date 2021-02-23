import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared_state/providers_exports.dart';
import '../video_list_exports.dart';

class VideoListPage extends StatefulWidget {
  static const String ROUTE = "/video";

  VideoListPage();
  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  int folderId = -1;

  @override
  Widget build(BuildContext context) {
    if (folderId == -1) {
      folderId = ModalRoute.of(context).settings.arguments;
      print("FilderID $folderId");
      context.read<VideoPool>().setFolderId(folderId);
    }
    return Scaffold(
      appBar: AppBar(title: Text("Files")),
      body: SafeArea(child: VideoList()),
    );
  }
}
