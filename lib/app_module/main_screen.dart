import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    ); 
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 18, 74, 20),
      leading: _buildLeadingLogo(),
      title: const Text('បណ្ណាល័យកសិកម្ម'),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            debugPrint('Search');
          },
        ),
      ],
    );
  }

  Widget _buildLeadingLogo(){
    return Container(
      padding: const EdgeInsets.only(left: 5, bottom: 5),
      child:(Image.asset('assets/images/logo.png')),
    );
  }


  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'ទំព័រដើម',
        ),
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


  Widget _buildBody(){
   return _buildListView();
  }

  Widget _buildListView(){
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.map),
          title: Text('Map'),
        ),
        ListTile(
          leading: Icon(Icons.photo),
          title: Text('Album'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Phone'),
        ),
      ],
    );
  }
  
}