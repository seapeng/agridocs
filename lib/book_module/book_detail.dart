import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'read_book.dart';

class BookDetail extends StatefulWidget {
  final int id;
  final String code;
  final String title;
  final String author;
  final DateTime issued;
  final int page;
  final String isbn;
  final String issn;
  final String image;
  final String ebook;
  final DateTime createdAt;
  final String language;
  final String bookCategory;

  const BookDetail({
    required this.id,
    required this.code,
    required this.title,
    required this.author,
    required this.issued,
    required this.page,
    required this.isbn,
    required this.issn,
    required this.image,
    required this.ebook,
    required this.createdAt,
    required this.language,
    required this.bookCategory,
  });

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  void initState() {
    super.initState();
    _countBookView(widget.id);
  }

  Future<void> _countBookView(int bookId) async {
    debugPrint(bookId.toString());
    final url =
        Uri.parse('https://agridocs-api.daovitou.net/mobile/v1/books/$bookId');
    // final response = await http.get(url);
    await http.get(url);

    // if (response.statusCode == 200) {
    //   debugPrint("View counted successfully");
    // } else {
    //   debugPrint("Failed to count view: ${response.statusCode}");
    // }
  }

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
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildBookImage(),
          _buildBookTitle(),
          _buildReadButton(),
          _buildDetailRow('អ្នកនិពន្ធ: ', widget.author),
          _buildDetailRow('ថ្ងៃបោះពុម្ភផ្សាយ: ',
              DateFormat('dd-MM-yyyy').format(widget.issued)),
          _buildDetailRow('ភាសា: ', widget.language),
          _buildDetailRow('ចំនួនទំព័រ: ', widget.page.toString()),
          _buildDetailRow('ISBN: ', widget.isbn),
          _buildDetailRow('ISSN: ', widget.issn),
          _buildDetailRow('ប្រភេទសៀវភៅ: ', widget.bookCategory),
        ],
      ),
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

  Widget _buildBookTitle() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildReadButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
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
