import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'video_model.dart';
import 'video_search_screen.dart';

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
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.network(
            "https://img.youtube.com/vi/${video.youtubeId}/mqdefault.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 30,
          ),
          child: Text(
            video.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(0.0),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               video.title,
        //             ),
        //             SizedBox(height: 5),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
