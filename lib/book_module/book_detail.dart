import 'package:flutter/material.dart';

class BookDetail extends StatefulWidget {
  // const BookDetail({super.key});

  final String title;
  final String image;
  const BookDetail({required this.title, required this.image});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(widget.title),
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ), // Set border radius
              child: Image.network(
                widget.image, // Replace with your image path
                fit: BoxFit.cover,
                height: double.maxFinite,
              ),
            ),
          ),
          Center(
            child: Text(widget.title),
          ),
        ],
      ),
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
}
