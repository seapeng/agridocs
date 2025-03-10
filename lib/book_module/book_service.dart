import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'book_model.dart';

class BookService {
  static Future read({
    int page = 1,
    int categoryId = 0,
    required Function(Future<BookModel>) onRes,
    required Function(Object?) onError,
  }) async {
    String url =
        "https://agridocs-api.daovitou.net/mobile/v1/books?pages=$page&limit=8";

    if (categoryId > 0) {
      url =
          "https://agridocs-api.daovitou.net/mobile/v1/books/category/$categoryId";
    }

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
    required String keyword,
    required Function(Future<BookModel>) onRes,
    required Function(Object?) onError,
  }) async {
    String url =
        "https://agridocs-api.daovitou.net/mobile/v1/books?search=$keyword";
    try {
      http.Response response = await http.get(Uri.parse(url));
      final data = compute(bookModelFromJson, response.body);
      onRes(data);
      onError(null);
    } catch (e) {
      onError(e);
    }
  }

  static Future category({
    // required int categoryId,
    required Function(Future<BookModel>) onRes,
    required Function(Object?) onError,
  }) async {
    String url = "https://agridocs-api.daovitou.net/mobile/v1/books/category/1";
    try {
      http.Response response = await http.get(Uri.parse(url));
      final data = compute(bookModelFromJson, response.body);
      onRes(data);
      // onError(null);
    } catch (e) {
      onError(e);
    }
  }
}
