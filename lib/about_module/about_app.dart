import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_module/theme_logic.dart';
import '../app_module/language_logic.dart';

import 'about_screen.dart';

Widget providerAboutApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeLogic()),
      ChangeNotifierProvider(create: (context) => LanguageLogic()),
    ],
    child: AboutApp(),
  );
}

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    ThemeMode mode = context.watch<ThemeLogic>().mode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AboutScreen(),
      themeMode: mode,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Battambang',
        appBarTheme: AppBarTheme(
          foregroundColor: Color(0xFF000000), //here you can give the text color
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Battambang',
        appBarTheme: AppBarTheme(
          foregroundColor: Color(0xFFFFFFFF), //here you can give the text color
        ),
      ),
    );
  }
}
