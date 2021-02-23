import 'package:flutter/material.dart';

import '../home.dart';

class HomePage extends StatefulWidget {
  static const String ROUTE = "/";

  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print("Home page called");

    return Scaffold(
      appBar: AppBar(title: Text("Video Player"), actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String text = await showSearch(
                context: context,
                delegate: DataSearch(),
              );
            })
      ]),
      drawer: VideoHomeDrawer(),
      body: Center(
        child: const FolderList(),
      ),
    );
  }
}
