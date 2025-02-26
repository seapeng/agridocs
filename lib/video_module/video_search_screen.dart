import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../app_module/translate_data.dart';
import '../app_module/translate_logic.dart';

import 'video_model.dart';
import 'video_search_logic.dart';
import 'video_detail.dart';

class VideoSearchScreen extends StatefulWidget {
  const VideoSearchScreen({super.key});

  @override
  State<VideoSearchScreen> createState() => _VideoSearchScreenState();
}

class _VideoSearchScreenState extends State<VideoSearchScreen> {
  Translate _lang = Khmer();
  @override
  Widget build(BuildContext context) {
    _lang = context.watch<TranslateLogic>().lang;
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchBar(),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: SizedBox(),
        ),
      ),
      body: _buildBody(),
    );
  }

  final _searchCtrl = TextEditingController();

  Widget _buildSearchBar() {
    return SearchBar(
      controller: _searchCtrl,
      hintText: _lang.searchHint,
      textInputAction: TextInputAction.search,
      trailing: [
        IconButton(
          onPressed: () {
            _searchCtrl.clear();
          },
          icon: const Icon(Icons.cancel),
        ),
        IconButton(
          onPressed: () {
            context.read<VideoSearchLogic>().setLoading();
            context.read<VideoSearchLogic>().search(_searchCtrl.text.trim());
          },
          icon: const Icon(Icons.search),
        ),
      ],
      onSubmitted: (text) {
        context.read<VideoSearchLogic>().setLoading();
        context.read<VideoSearchLogic>().search(text.trim());
      },
    );
  }

  Widget _buildBody() {
    Object? error = context.watch<VideoSearchLogic>().error;
    bool loading = context.watch<VideoSearchLogic>().loading;
    List<Videos> records = context.watch<VideoSearchLogic>().records;

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return _buildErrorMessage(error);
    } else {
      return _buildGridView(records);
    }
  }

  Widget _buildErrorMessage(Object error) {
    debugPrint(error.toString());
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 50),
          const Text("Something went wrong"),
          ElevatedButton(
            onPressed: () {
              context.read<VideoSearchLogic>().setLoading();
              context.read<VideoSearchLogic>().search(_searchCtrl.text.trim());
            },
            child: const Text("RETRY"),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Videos> items) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<VideoSearchLogic>().setLoading();
        context.read<VideoSearchLogic>().search(_searchCtrl.text.trim());
      },
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildListItem(items[index]);
        },
      ),
      // child: GridView.builder(
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 1,
      //     mainAxisSpacing: 5,
      //     crossAxisSpacing: 5,
      //     childAspectRatio: 4 / 6,
      //   ),
      //   itemCount: items.length,
      //   physics: const BouncingScrollPhysics(),
      //   itemBuilder: (context, index) {
      //     return _buildItem(items[index]);
      //   },
      // ),
    );
  }

  // Widget _buildItem(Videos item) {
  //   return Card(
  //     child: Column(
  //       children: [
  //         Expanded(
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(10),
  //             child: Image.network(
  //               "https://img.youtube.com/vi/${item.youtubeId}/mqdefault.jpg",
  //               width: double.maxFinite,
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text(
  //             item.title,
  //             maxLines: 1,
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildListItem(Videos video) {
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.today,
                        size: 12,
                      ),
                      SizedBox(width: 3),
                      Text(
                        DateFormat('dd-MM-yyyy').format(video.published),
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.visibility,
                        size: 12,
                      ),
                      SizedBox(width: 3),
                      Text(
                        343.toString(),
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
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

  void _pageDetail(Videos video) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => VideoDetail(
          id: video.id,
          title: video.title,
          youtubeId: video.youtubeId,
          author: video.author,
          published: video.published,
          language: video.language.name,
          videoCateogy: video.videoCategory.name,
        ),
      ),
    );
  }
}
