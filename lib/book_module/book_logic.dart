import 'package:flutter/material.dart';

import 'book_model.dart';
import 'book_service.dart';

class BookLogic extends ChangeNotifier {
  List<Books> _records = [];
  List<Books> get records => _records;

  bool _loading = false;
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
        _loading = false;
        debugPrint("sdfhdsjfdsjfbdsjfbd");

        notifyListeners();
      },
      onError: (err) {
        _error = err;
        _loading = false;
        notifyListeners();
      },
    );
  }

  Future read() async {
    await BookService.read(
      onRes: (value) async {
        final data = await value;
        _records = data.data.books;
        _loading = false;
        notifyListeners();
      },
      onError: (err) {
        _error = err;
        _loading = false;
        notifyListeners();
      },
    );
  }
}
