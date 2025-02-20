import 'package:flutter/material.dart';

class BookSplashscreen extends StatelessWidget {
  const BookSplashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
