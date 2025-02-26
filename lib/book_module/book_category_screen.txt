import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_category_logic.dart';

class BookCategoryScreen extends StatefulWidget {
  const BookCategoryScreen({super.key});

  @override
  State<BookCategoryScreen> createState() => _BookCategoryScreenState();
}

class _BookCategoryScreenState extends State<BookCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<BookCategoryLogic>().readMe();
    return Scaffold();
  }
}
