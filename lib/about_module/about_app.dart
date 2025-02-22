import 'package:flutter/material.dart';
import 'about_screen.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AboutScreen(),
      theme: ThemeData(
        fontFamily: 'Battambang',
        appBarTheme: AppBarTheme(
          foregroundColor: Color(0xFF00ab04), //here you can give the text color
        ),
      ),
    );
  }
}
