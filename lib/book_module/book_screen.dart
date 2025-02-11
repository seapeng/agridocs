import 'package:agridocs/book_module/book_in_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'book_model.dart';
import 'book_category_model.dart';
import 'book_detail.dart';
import 'book_search_screen.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
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
                builder: (context) => BookSearchScreen(),
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
    return Column(
      // physics: BouncingScrollPhysics(),
      children: <Widget>[
        _buildCategoryListView(),
        Expanded(
          child: _buildBookGridView(),
        ),
      ],
    );
  }

  void _bookInCategory(String title) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => BookInCategory(title: title),
      ),
    );
  }

  void _pageDetail(BookModel book) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => BookDetail(
          title: book.title,
          image: book.image,
          author: book.author,
          issued: book.issued,
          pages: book.pages,
          ebook: book.ebook,
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

  Widget _buildBookGridView() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          mainAxisSpacing: 5, // Space between rows
          crossAxisSpacing: 10, // Space between columns
          childAspectRatio: 1 / 1.7,
        ),
        itemCount: bookModelList.length,
        itemBuilder: (context, index) {
          return _buildBookGridItem(bookModelList[index]);
        },
      ),
    );
  }

  Widget _buildBookGridItem(BookModel book) {
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
                    height: double.maxFinite,
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
                        "20 មករា 2025",
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
      ),
    );
  }
}
