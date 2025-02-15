import 'package:flutter/material.dart';

class MainSplashscreen extends StatelessWidget {
  const MainSplashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
