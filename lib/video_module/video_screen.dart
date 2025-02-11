import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'video_model.dart';
import 'video_search_screen.dart';
import 'video_detail.dart';
import 'video_category_model.dart';

class VideoScreen extends StatefulWidget {
  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
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
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => VideoSearchScreen(),
              ),
            );
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

  Widget _buildBody() {
    return Column(
      children: [
        _buildCategoryListView(),
        Expanded(
          child: _buildVideoListView(),
        ),
      ],
    );
  }

  int _selectedIndex = 0;

  Widget _buildCategoryListView() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: videoCategoryModelList.length,
        itemBuilder: (context, index) {
          return _categoryCard(videoCategoryModelList[index], index);
        },
      ),
    );
  }

  Widget _categoryCard(VideoCategoryModel category, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Card(
        color: isSelected ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            category.name,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoListView() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: videoModelList.length,
      itemBuilder: (context, index) {
        return _videoCard(videoModelList[index]);
      },
    );
  }

  Widget _videoCard(VideoModel video) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        child: Column(
          children: [
            InkWell(
              onTap: () => _pageDetail(video),
              child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    "https://img.youtube.com/vi/${video.youtubeId}/mqdefault.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 10,
                ),
                child: Text(
                  video.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 10,
              ),
              child: Row(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min, // Keeps the row compact
                    children: [
                      Icon(
                        Icons.today,
                        size: 12,
                      ),
                      SizedBox(width: 3),
                      Text(
                        "20 មករា 2025",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min, // Keeps the row compact
                    children: [
                      Icon(
                        Icons.visibility,
                        size: 12,
                      ),
                      SizedBox(width: 3),
                      Text(
                        video.view.toString(),
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      // Adds spacing between text and icon
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pageDetail(VideoModel video) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => VideoDetail(
          title: video.title,
          youtubeId: video.youtubeId,
          published: video.published,
          author: video.author,
          view: video.view,
        ),
      ),
    );
  }
}
