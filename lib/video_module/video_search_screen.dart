import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'video_model.dart';
import 'video_search_logic.dart';

class VideoSearchScreen extends StatefulWidget {
  const VideoSearchScreen({super.key});

  @override
  State<VideoSearchScreen> createState() => _VideoSearchScreenState();
}

class _VideoSearchScreenState extends State<VideoSearchScreen> {
  @override
  Widget build(BuildContext context) {
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
      hintText: "Search...",
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
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 4 / 6,
        ),
        itemCount: items.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildItem(items[index]);
        },
      ),
    );
  }

  Widget _buildItem(Videos item) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://img.youtube.com/vi/${item.youtubeId}/mqdefault.jpg",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
