import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'book_category_model.dart';

class BookCategoryService {
  static Future read({
    int page = 1,
    required Function(Future<BookCategoryModel>) onRes,
    required Function(Object?) onError,
  }) async {
    String url = "https://agridocs-api.daovitou.net/mobile/v1/book-categories";
    try {
      http.Response response = await http.get(Uri.parse(url));
      final data = compute(bookCategoryModelFromJson, response.body);
      onRes(data);
      // onError(null);
    } catch (e) {
      onError(e);
    }
  }
}
