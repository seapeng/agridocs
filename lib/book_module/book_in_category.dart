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
    return Card(
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () => _pageDetail(book.title, book.image),
        child: Row(
          children: [
            Container(
              width: 100, // Set the desired width
              height: 100, // Set the desired height
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(book.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      book.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.today,
                          size: 12,
                        ),
                        SizedBox(width: 3),
                        Text(
                          "12 Mar 2024",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 20),
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pageDetail(String title, String image) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => BookDetail(
          title: title,
          image: image,
        ),
      ),
    );
  }
}
