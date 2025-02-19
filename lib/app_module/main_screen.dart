import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language_data.dart';
import 'language_logic.dart';
import 'theme_logic.dart';

import '../book_module/book_provider.dart';
import '../video_module/video_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Language _lang = Khmer();
  int _langIndex = 0;
  @override
  Widget build(BuildContext context) {
    _lang = context.watch<LanguageLogic>().lang;
    _langIndex = context.watch<LanguageLogic>().langIndex;

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
            leading: Icon(Icons.perm_phone_msg),
            title: const Text('ទំនាក់ទំនង'),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                _currentIndex = 0;
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: const Text('អំពីយើង'),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.light_mode),
            title: Text(_lang.themeColor),
            children: [
              ListTile(
                leading: Icon(Icons.phone_android),
                title: Text(_lang.toSystemMode),
                onTap: () {},
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
                title: Text("ប្តូរទៅភាសារខ្មែរ"),
                onTap: () {
                  context.read<LanguageLogic>().changToKhmer();
                },
                trailing: _langIndex == 0 ? Icon(Icons.check) : null,
              ),
              ListTile(
                leading: Text("EN"),
                title: Text("Change to English"),
                onTap: () {
                  context.read<LanguageLogic>().changeToEnglish();
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
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.folder),
          label: 'ឯកសារ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.smart_display),
          label: 'វីដេអូ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'បន្ថែម',
        ),
      ],
    );
  }
}
