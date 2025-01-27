import 'package:flutter/material.dart';
import 'video_screen.dart';

class VideoApp extends StatelessWidget {
  const VideoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Battambang',
          appBarTheme: AppBarTheme(
              backgroundColor: const Color.fromARGB(255, 33, 112, 35),
              foregroundColor: Colors.white //here you can give the text color
              ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
          )),
    );
  }
}
