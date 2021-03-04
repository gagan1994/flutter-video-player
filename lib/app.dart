import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'config/palette.dart';
import 'db/moor_database.dart';
import 'pages/home/home.dart';
import 'pages/splash/splash.dart';
import 'pages/video_list/video_list_exports.dart';
import 'pages/video_player/video_player_exports.dart';
import 'shared_state/providers_exports.dart';

class App extends StatelessWidget {
  Player player = new Player(new AppDatabase());
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: player),
        ChangeNotifierProvider.value(value: player.folder),
        ChangeNotifierProvider.value(value: player.videos),
      ],
      child: MaterialApp(
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonColor: Palette.accentColor,
          canvasColor: Palette.canvasColor,
          accentColor: Palette.accentColor,
          primaryColor: Palette.primaryColor,
          buttonTheme: const ButtonThemeData(
            buttonColor: Palette.accentColor,
            textTheme: ButtonTextTheme.primary,
          ),
          colorScheme: const ColorScheme.light(
            primary: Colors.black, //flat button text color
          ),
        ),
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
        initialRoute: SplashPage.ROUTE,
        routes: {
          SplashPage.ROUTE: (context) => SplashPage(),
          HomePage.ROUTE: (context) => HomePage(),
          VideoListPage.ROUTE: (context) => VideoListPage(),
          LandscapePlayer.ROUTE: (context) => LandscapePlayer(),
        },
      ),
    );
  }
}
