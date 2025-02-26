import 'package:flutter/material.dart';

import 'book_model.dart';
import 'book_service.dart';

class BookLogic extends ChangeNotifier {
  List<Books> _records = [];
  List<Books> get records => _records;

  bool _loading = false;
  bool get loading => _loading;

  bool _moreData = true;
  bool get moreData => _moreData;

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

        if (data.data.totalRecords == _records.length) {
          _moreData = false;
        } else {
          _moreData = true;
        }

        // if (data.data.totalRecords == _records.length) {
        //   _loading = false;
        // } else {
        //   _loading = true;
        // }
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

        if (data.data.totalRecords == _records.length) {
          _moreData = false;
        } else {
          _moreData = true;
        }
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
