import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../app_module/translate_data.dart';
import '../app_module/translate_logic.dart';

import 'book_model.dart';
import 'book_search_logic.dart';
import 'book_detail.dart';

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key});

  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
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
            context.read<BookSearchLogic>().setLoading();
            context.read<BookSearchLogic>().search(_searchCtrl.text.trim());
          },
          icon: const Icon(Icons.search),
        ),
      ],
      onSubmitted: (text) {
        context.read<BookSearchLogic>().setLoading();
        context.read<BookSearchLogic>().search(text.trim());
      },
    );
  }

  Widget _buildBody() {
    Object? error = context.watch<BookSearchLogic>().error;
    bool loading = context.watch<BookSearchLogic>().loading;
    List<Books> records = context.watch<BookSearchLogic>().records;

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
    // debugPrint(error.toString());
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 50),
          const Text("Something went wrong"),
          ElevatedButton(
            onPressed: () {
              context.read<BookSearchLogic>().setLoading();
              context.read<BookSearchLogic>().search(_searchCtrl.text.trim());
            },
            child: const Text("RETRY"),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Books> books) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async {
            context.read<BookSearchLogic>().setLoading();
            context.read<BookSearchLogic>().search(_searchCtrl.text.trim());
          },
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 4 / 7,
            ),
            itemCount: books.length,
            itemBuilder: (context, index) {
              return _buildItem(books[index]);
            },
          ),
        ),
        if (books.isEmpty)
          Positioned.fill(
            child: Container(
              alignment: Alignment.center,
              // color: Color(0xFFfef7ff), // Optional: Dim background
              child: Center(
                child: Text(_lang.noData),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildItem(Books book) {
    return Card(
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
                ),
                child: Image.network(
                  book.image,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              book.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
                      DateFormat('dd-MM-yyyy').format(book.createdAt),
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
                      87.toString(),
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
          isbn: book.isbn,
          issn: book.issn,
          image: book.image,
          ebook: book.ebook,
          createdAt: book.createdAt,
          language: book.language.name,
          bookCategory: book.bookCategory.name,
        ),
      ),
    );
  }
}
