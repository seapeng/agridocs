import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_app.dart';
import 'book_logic.dart';
import 'book_search_logic.dart';

Widget bookProvider() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => BookLogic()),
      ChangeNotifierProvider(create: (context) => BookSearchLogic()),
    ],
    child: const BookApp(),
  );
}
