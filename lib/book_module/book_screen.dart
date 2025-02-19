import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_logic.dart';
import 'book_model.dart';
import 'book_search_screen.dart';
import 'book_detail.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<BookScreen> {
  final _scroller = ScrollController();
  bool _showUpButton = false;

  @override
  void initState() {
    super.initState();
    _scroller.addListener(_scrollListener);
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
        debugPrint("Reached the bottom");
        context.read<BookLogic>().readAppend();
      }
    });
  }

  @override
  void dispose() {
    _scroller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _showUpButton ? _buildUpButton() : null,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: _buildLeadingLogo(),
      title: const Text("បណ្ណាល័យកសិកម្ម"),
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
    Object? error = context.watch<BookLogic>().error;
    bool loading = context.watch<BookLogic>().loading;
    List<Books> records = context.watch<BookLogic>().records;

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return _buildErrorMessage(error);
    } else {
      return _buildListView(records);
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
              context.read<BookLogic>().setLoading();
              context.read<BookLogic>().read();
            },
            child: const Text("RETRY"),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<Books> items) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        controller: _scroller,
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index < items.length) {
            return _buildListItem(items[index]);
          } else {
            return Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListItem(Books book) {
    // return Card(
    //   child: ListTile(
    //     title: Image.network(
    //         "https://img.youtube.com/vi/${item.youtubeId}/mqdefault.jpg"),
    //     subtitle: Text(item.title),
    //   ),
    // );
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        child: Column(
          children: [
            InkWell(
              onTap: () => _pageDetail(book),
              child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    book.image,
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
                  book.title,
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
                        343.toString(),
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

  void _pageDetail(Books book) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => BookDetail(
          id: book.id,
          code: book.code,
          title: book.title,
          author: book.author,
          issued: book.issued,
          page: book.page,
          image: book.image,
          ebook: book.ebook,
        ),
      ),
    );
  }
}
