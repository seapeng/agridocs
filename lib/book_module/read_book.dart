import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ReadBook extends StatefulWidget {
  // const ReadBook({super.key});
  final String title;
  final String ebook;

  const ReadBook({
    required this.title,
    required this.ebook,
  });

  @override
  State<ReadBook> createState() => _ReadBookState();
}

class _ReadBookState extends State<ReadBook> {
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
    return PDF(
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: false,
      pageFling: false,
    ).cachedFromUrl(
      widget.ebook,
      placeholder: (progress) => Center(child: Text('$progress %')),
    );
    // return Text('Hello');
  }
}
