import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_module/theme_logic.dart';
import '../app_module/language_logic.dart';

import 'video_logic.dart';
import 'video_screen.dart';
import 'video_splashscreen.dart';

Widget providerVideoApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeLogic()),
      ChangeNotifierProvider(create: (context) => LanguageLogic()),
    ],
    child: VideoApp(),
  );
}

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  State<VideoApp> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  @override
  Widget build(BuildContext context) {
    ThemeMode mode = context.watch<ThemeLogic>().mode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _buildLoadingScreen(),
      themeMode: mode,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Battambang',
        appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromARGB(255, 33, 112, 35),
            foregroundColor: Colors.white //here you can give the text color
            ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Battambang',
        appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromARGB(255, 33, 112, 35),
            foregroundColor: Colors.white //here you can give the text color
            ),
      ),
    );
  }

  Future _fetchData() async {
    await context.read<VideoLogic>().read();
  }

  Widget _buildLoadingScreen() {
    return FutureBuilder(
      future: _fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return VideoScreen();
        } else {
          return const VideoSplashscreen();
        }
      },
    );
  }
}
