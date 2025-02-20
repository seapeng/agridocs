import 'package:flutter/material.dart';

import 'book_model.dart';
import 'book_service.dart';

class BookLogic extends ChangeNotifier {
  List<Books> _records = [];
  List<Books> get records => _records;

  bool _loading = true;
  bool get loading => _loading;

  Object? _error;
  Object? get error => _error;

  void setLoading() {
    _loading = true;
    notifyListeners();
  }

  int _page = 1;

  Future readAppend() async {
    _page++;
    await BookService.read(
      page: _page,
      onRes: (value) async {
        final data = await value;
        _records += data.data.books;
        if (data.data.totalRecords == _records.length) {
          _loading = false;
        } else {
          _loading = true;
        }
        notifyListeners();
      },
      onError: (err) {
        _error = err;
        notifyListeners();
      },
    );
  }

  Future read() async {
    await BookService.read(
      onRes: (value) async {
        final data = await value;
        _records = data.data.books;
        if (data.data.totalRecords == _records.length) {
          _loading = false;
        } else {
          _loading = true;
        }
        notifyListeners();
      },
      onError: (err) {
        _error = err;
        notifyListeners();
      },
    );
  }
}
