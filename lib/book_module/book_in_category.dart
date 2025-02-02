import 'package:flutter/material.dart';
import 'book_model.dart';
import 'book_search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'book_detail.dart';

class BookInCategory extends StatefulWidget {
  // const BookInCategory({super.key});
  final String title;
  const BookInCategory({required this.title});

  @override
  State<BookInCategory> createState() => _BookInCategoryState();
}

class _BookInCategoryState extends State<BookInCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(widget.title),
      body: _buildBody(bookModelList),
    );
  }

  AppBar _buildAppBar(title) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => BookSearchScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody(List<BookModel> books) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return _buildBookItem(books[index]);
      },
    );
  }

  Widget _buildBookItem(BookModel book) {
    return ListTile(
      leading: Image.network(
        book.image,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(book.title),
      subtitle: Text(book.author),
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => BookDetail(
              title: book.title,
              image: book.image,
            ),
          ),
        );
      },
    );
  }
}
