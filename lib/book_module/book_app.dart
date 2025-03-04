import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_module/theme_logic.dart';
import '../app_module/translate_logic.dart';

import 'book_logic.dart';
import 'book_screen.dart';
import 'book_splashscreen.dart';

Widget providerBookApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeLogic()),
      ChangeNotifierProvider(create: (context) => TranslateLogic()),
    ],
    child: BookApp(),
  );
}

class BookApp extends StatefulWidget {
  const BookApp({super.key});
  @override
  State<BookApp> createState() => _BookAppState();
}

class _BookAppState extends State<BookApp> {
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

  Future<void> _fetchData() async {
    await context.read<BookLogic>().read(0);
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
