import 'package:flutter/material.dart';
import 'contact_screen.dart';

class ContactApp extends StatefulWidget {
  const ContactApp({super.key});

  @override
  State<ContactApp> createState() => _ContactAppState();
}

class _ContactAppState extends State<ContactApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactScreen(),
      theme: ThemeData(
        fontFamily: 'Battambang',
        appBarTheme: AppBarTheme(
          foregroundColor: Color(0xFF00ab04), //here you can give the text color
        ),
      ),
    );
  }
}
