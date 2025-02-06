import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'read_book.dart';

class BookDetail extends StatefulWidget {
  // const BookDetail({super.key});

  final String title;
  final String image;
  final String author;
  final DateTime issued;
  final int pages;
  final String ebook;
  const BookDetail({
    required this.title,
    required this.image,
    required this.author,
    required this.issued,
    required this.pages,
    required this.ebook,
  });

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(widget.title),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(title) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildBookImage(),
        _buildReadButton(),
        _buildDetailRow('អ្នកនិពន្ធ: ', widget.author),
        _buildDetailRow('ថ្ងៃបោះពុម្ភផ្សាយ: ', widget.issued.toString()),
        _buildDetailRow('ភាសា: ', 'ខ្មែរ'),
        _buildDetailRow('ចំនួនទំព័រ: ', widget.pages.toString()),
        _buildDetailRow('ប្រភេទសៀវភៅ: ', 'កសិកម្ម'),
        _buildDetailRow('Url: ', widget.ebook),
      ],
    );
  }

  Widget _buildBookImage() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 40, right: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          widget.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildReadButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20, top: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          _readBook(widget.title, widget.ebook);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_stories,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(width: 5),
            Text(
              'អានសៀវភៅ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _readBook(String title, String ebook) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => ReadBook(title: title, ebook: ebook),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
