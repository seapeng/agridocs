import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'translate_data.dart';
import 'translate_logic.dart';
import 'theme_logic.dart';

import '../book_module/book_provider.dart';
import '../video_module/video_provider.dart';
import '../about_module/about_app.dart';
import '../contact_module/contact_app.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Translate _lang = Khmer();
  int _langIndex = 0;
  @override
  Widget build(BuildContext context) {
    _lang = context.watch<TranslateLogic>().lang;
    _langIndex = context.watch<TranslateLogic>().langIndex;

    return Scaffold(
      key: _scaffoldKey,
      body: _buildBody(),
      drawer: _buildDrawer(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _currentIndex,
      children: [
        bookProvider(),
        videoProvider(),
      ],
    );
  }

  Widget _buildDrawer() {
    ThemeMode mode = context.watch<ThemeLogic>().mode;
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text(_lang.about),
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const AboutApp(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.perm_phone_msg),
            title: Text(_lang.contact),
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const ContactApp(),
                ),
              );
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.light_mode),
            title: Text(_lang.themeColor),
            children: [
              ListTile(
                leading: Icon(Icons.phone_android),
                title: Text(_lang.toSystemMode),
                onTap: () {
                  context.read<ThemeLogic>().changeToSystem();
                },
                trailing: mode == ThemeMode.system ? Icon(Icons.check) : null,
              ),
              ListTile(
                leading: Icon(Icons.light_mode),
                title: Text(_lang.toLightMode),
                onTap: () {
                  context.read<ThemeLogic>().changeToLight();
                },
                trailing: mode == ThemeMode.light ? Icon(Icons.check) : null,
              ),
              ListTile(
                leading: Icon(Icons.dark_mode),
                title: Text(_lang.toDarkMode),
                onTap: () {
                  context.read<ThemeLogic>().changeToDark();
                },
                trailing: mode == ThemeMode.dark ? Icon(Icons.check) : null,
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.language),
            title: Text(_lang.language),
            children: [
              ListTile(
                leading: Text("ខ្មែរ"),
                title: Text(_lang.changeToKhmer),
                onTap: () {
                  context.read<TranslateLogic>().changToKhmer();
                },
                trailing: _langIndex == 0 ? Icon(Icons.check) : null,
              ),
              ListTile(
                leading: Text("EN"),
                title: Text(_lang.changeToEnglish),
                onTap: () {
                  context.read<TranslateLogic>().changeToEnglish();
                },
                trailing: _langIndex == 1 ? Icon(Icons.check) : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _currentIndex = 0;

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        if (index == 2) {
          _scaffoldKey.currentState!.openDrawer();
          return;
        } else {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.folder),
          label: _lang.books,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.smart_display),
          label: _lang.videos,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: _lang.more,
        ),
      ],
    );
  }
}
