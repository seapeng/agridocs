import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../app_module/translate_data.dart';
import '../app_module/translate_logic.dart';

import 'video_logic.dart';
import 'video_model.dart';
import 'video_search_screen.dart';
import 'video_detail.dart';
import 'video_category_model.dart';
import 'video_category_logic.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  Translate _lang = Khmer();
  final _scroller = ScrollController();
  bool _showUpButton = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scroller.addListener(_scrollListener);
  }

  Future<void> _fetchData() async {
    await context.read<VideoCategoryLogic>().read();
  }

  _scrollListener() {
    setState(() {
      if (_scroller.hasClients && _scroller.position.pixels >= 1000) {
        _showUpButton = true;
      } else {
        _showUpButton = false;
      }

      if (_scroller.hasClients &&
          _scroller.position.pixels == _scroller.position.maxScrollExtent) {
        context.read<VideoLogic>().setLoading();
        context.read<VideoLogic>().readAppend();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _lang = context.watch<TranslateLogic>().lang;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _showUpButton ? _buildUpButton() : null,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: _buildLeadingLogo(),
      title: Text(_lang.appName),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => const VideoSearchScreen(),
              ),
            );
          },
          icon: const Icon(Icons.search),
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

  Widget _buildUpButton() {
    return FloatingActionButton(
      child: const Icon(Icons.arrow_upward),
      onPressed: () {
        _scroller.animateTo(
          0.0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  Widget _buildBody() {
    Object? error = context.watch<VideoLogic>().error;
    List<Videos> records = context.watch<VideoLogic>().records;

    if (error != null) {
      return _buildErrorMessage(error);
    } else {
      return _buildListView(records);
    }
  }

  Widget _buildErrorMessage(Object error) {
    // debugPrint(error.toString());
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 50),
          const Text("Something went wrong"),
          ElevatedButton(
            onPressed: () {
              context.read<VideoLogic>().setLoading();
              context.read<VideoLogic>().read(0);
            },
            child: const Text("RETRY"),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<Videos> items) {
    bool loading = context.watch<VideoLogic>().loading;
    bool categoryLoading = context.watch<VideoLogic>().categoryLoading;

    List<Categories> categoriesRecords =
        context.watch<VideoCategoryLogic>().categories;
    return Column(
      children: [
        _buildCategoryListView(categoriesRecords),
        Expanded(
          child: Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: _scroller,
                  itemCount: items.length + 1,
                  itemBuilder: (context, index) {
                    if (index < items.length) {
                      return _buildListItem(items[index]);
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: loading
                            ? const CircularProgressIndicator()
                            : Text(_lang.noMoreData),
                      );
                    }
                  },
                ),
              ),
              if (categoryLoading)
                Positioned.fill(
                  child: Container(
                    color: Color(0xFFfef7ff), // Optional: Dim background
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

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
                        DateFormat('dd-MM-yyyy').format(video.createdAt),
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
                        video.viewer.toString(),
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

  Widget _buildCategoryListView(List<Categories> categories) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return _categoryCard(categories[index], categories[index].id);
          },
        ),
      ),
    );
  }

  int _selectedIndex = 0;

  Widget _categoryCard(Categories category, index) {
    bool isSelected = _selectedIndex == index;
    // debugPrint(index.toString());
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        context.read<VideoLogic>().setCategoryLoading();
        context.read<VideoLogic>().read(category.id);
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

  @override
  void dispose() {
    _scroller.removeListener(_scrollListener);
    super.dispose();
  }
}
