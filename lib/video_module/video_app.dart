import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'video_logic.dart';
import 'video_screen.dart';
import 'video_splashscreen.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  State<VideoApp> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _buildLoadingScreen(),
      theme: ThemeData(
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
