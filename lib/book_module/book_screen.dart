import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../app_module/translate_data.dart';
import '../app_module/translate_logic.dart';

import 'book_logic.dart';
import 'book_model.dart';
import 'book_search_screen.dart';
import 'book_detail.dart';
import 'book_category_model.dart';
import 'book_category_screen.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  Translate _lang = Khmer();
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
    _lang = context.watch<TranslateLogic>().lang;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _showUpButton == true ? _buildUpButton() : null,
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
                builder: (context) => const BookSearchScreen(),
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
    List<Books> records = context.watch<BookLogic>().records;

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
              context.read<BookLogic>().setLoading();
              context.read<BookLogic>().read();
            },
            child: const Text("RETRY"),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Books> books) {
    bool loading = context.watch<BookLogic>().loading;
    // debugPrint(loading.toString());

    return Column(
      children: [
        _buildCategoryListView(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {},
            child: GridView.builder(
              controller: _scroller,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                mainAxisSpacing: 5, // Space between rows
                crossAxisSpacing: 10, // Space between columns
                childAspectRatio: 4 / 7,
              ),
              itemCount: books.length + 1,
              itemBuilder: (context, index) {
                if (index < books.length) {
                  // debugPrint(index.toString());
                  // debugPrint("Lenght: ${books.length.toString()}");
                  return _buildItem(books[index]);
                } else {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: loading
                        ? CircularProgressIndicator() // Shows at the bottom when loading more
                        : Text(_lang.noMoreData),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(Books book) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _pageDetail(book),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ), // Set border radius
                  child: Image.network(
                    book.image, // Replace with your image path
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 8,
                right: 8,
              ), // Top margin of 20
              child: Text(
                book.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Keeps the row compact
                    children: [
                      Icon(
                        Icons.today,
                        size: 12,
                      ),
                      SizedBox(width: 3),
                      Text(
                        DateFormat('dd-MM-yyyy').format(book.issued),
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Keeps the row compact
                    children: [
                      Icon(
                        Icons.visibility,
                        size: 12,
                      ),
                      SizedBox(width: 3),
                      Text(
                        book.viewer.toString(),
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      // Adds spacing between text and icon
                    ],
                  ),
                ),
              ],
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
          language: book.language.name,
          bookCategory: book.bookCategory.name,
        ),
      ),
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
        itemCount: bookCategoryModelList.length,
        itemBuilder: (context, index) {
          return _categoryCard(bookCategoryModelList[index], index);
        },
      ),
    );
  }

  Widget _categoryCard(BookCategoryModel category, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => BookCategoryScreen(),
        //   ),
        // );
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
}
