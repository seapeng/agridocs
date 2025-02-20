import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_logic.dart';
import 'book_screen.dart';
import 'book_splashscreen.dart';

class BookApp extends StatefulWidget {
  const BookApp({super.key});

  @override
  State<BookApp> createState() => _BookAppState();
}

class _BookAppState extends State<BookApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
    await context.read<BookLogic>().read();
  }

  Widget _buildLoadingScreen() {
    return FutureBuilder(
      future: _fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return BookScreen();
        } else {
          return const BookSplashscreen();
        }
      },
    );
  }
}
