import 'package:flutter/material.dart';

class VideoSplashscreen extends StatelessWidget {
  const VideoSplashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
