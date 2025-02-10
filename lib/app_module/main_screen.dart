import 'package:flutter/material.dart';

import '../book_module/book_screen.dart';
import '../video_module/video_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
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
        BookScreen(),
        VideoScreen(),
      ],
    );
  }

  Widget _buildDrawer() {
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
          ListTile(
            leading: Icon(Icons.light_mode),
            title: const Text('ពន្លឺ'),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                _currentIndex = 1;
              });
            },
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
