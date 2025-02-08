import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'video_search_screen.dart';
import 'video_model.dart';
import 'video_detail.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

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

  void _pageDetail(VideoModel video) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => VideoDetail(
          title: video.title,
          youtubeId: video.youtubeId,
          published: video.published,
        ),
      ),
    );
  }

  Widget _buildVideoGridItem(VideoModel video) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => _pageDetail(video),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                "https://img.youtube.com/vi/${video.youtubeId}/hqdefault.jpg",
                fit: BoxFit.cover,
                height: double.maxFinite,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
