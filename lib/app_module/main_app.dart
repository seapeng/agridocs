import 'package:flutter/material.dart';
import 'book_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BookScreen(),
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
