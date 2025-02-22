import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_module/theme_logic.dart';
import '../app_module/language_logic.dart';
import 'contact_screen.dart';

Widget providerContactApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeLogic()),
      ChangeNotifierProvider(create: (context) => LanguageLogic()),
    ],
    child: ContactApp(),
  );
}

class ContactApp extends StatefulWidget {
  const ContactApp({super.key});

  @override
  State<ContactApp> createState() => _ContactAppState();
}

class _ContactAppState extends State<ContactApp> {
  @override
  Widget build(BuildContext context) {
    ThemeMode mode = context.watch<ThemeLogic>().mode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactScreen(),
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
