import 'package:flutter/material.dart';
import 'video_model.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      // bottomNavigationBar: _buildBottomNavBar(),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.blue,
      //   onPressed: () {
      //     debugPrint("Hello WOrld");
      //   },
      //   child: Icon(
      //     Icons.arrow_upward,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: _buildLeadingLogo(),
      title: const Text(
        'បណ្ណាល័យកសិកម្ម',
        style: TextStyle(color: Colors.white),
      ),
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

  Widget _buildLeadingLogo() {
    return Container(
      padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
      child: (Image.asset('assets/images/logo.png')),
    );
  }

  // Widget _buildBottomNavBar() {
  //   return BottomNavigationBar(
  //     items: const <BottomNavigationBarItem>[
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.folder),
  //         label: 'ឯកសារ',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.smart_display),
  //         label: 'វីដេអូ',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.menu),
  //         label: 'បន្ថែម',
  //       ),
  //     ],
  //   );
  // }

  Widget _buildBody() {
    return _buildListView();
  }

  Widget _buildListView() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        _buildSingleTitle('វីដេអូ'),
        _buildVideoGridView(),
      ],
    );
  }

  Widget _buildSingleTitle(title) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildVideoGridView() {
    return GridView.builder(
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      // padding: EdgeInsets.all(),
      padding: EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        childAspectRatio: 2 / 1.5,
      ),
      itemCount: videoModelList.length,
      itemBuilder: (context, index) {
        return _buildVideoGridItem(videoModelList[index]);
      },
    );
  }

  Widget _buildVideoGridItem(VideoModel item) {
    return Container(
      alignment: Alignment.center,
      // padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: const Color.fromARGB(255, 229, 229, 229), // Border color
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ), // Set border radius
              child: Image.network(
                "https://img.youtube.com/vi/${item.youtubeId}/mqdefault.jpg",
                fit: BoxFit.cover,
                height: double.maxFinite,
              ),
            ),
          ),

          SizedBox(
            height: 8,
          ),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          // Adds spacing between text and icon
        ],
      ),
    );
  }
}
