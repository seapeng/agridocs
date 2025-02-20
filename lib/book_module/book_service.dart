import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'book_model.dart';

class BookService {
  static Future read({
    int page = 1,
    required Function(Future<BookModel>) onRes,
    required Function(Object?) onError,
  }) async {
    String url =
        "https://agridocs-api.daovitou.net/mobile/v1/books?pages=$page&limit=6";
    try {
      http.Response response = await http.get(Uri.parse(url));
      final data = compute(bookModelFromJson, response.body);
      onRes(data);
      // onError(null);
    } catch (e) {
      onError(e);
    }
  }

  static Future search({
    required String bookTitle,
    required Function(Future<BookModel>) onRes,
    required Function(Object?) onError,
  }) async {
    String url =
        "https://agridocs-api.daovitou.net/mobile/v1/books?search=$bookTitle";
    try {
      http.Response response = await http.get(Uri.parse(url));
      final data = compute(bookModelFromJson, response.body);
      onRes(data);
      onError(null);
    } catch (e) {
      onError(e);
    }
  }
}
