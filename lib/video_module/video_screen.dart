import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'video_model.dart';
import 'video_search_screen.dart';
import 'video_detail.dart';

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
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: videoModelList.length,
      itemBuilder: (context, index) {
        return _videoCard(videoModelList[index]);
      },
    );
  }

  Widget _videoCard(VideoModel video) {
    return Card(
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
