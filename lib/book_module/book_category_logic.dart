import 'package:flutter/material.dart';

import 'book_category_model.dart';
import 'book_category_service.dart';

class BookCategoryLogic extends ChangeNotifier {
  List<Categories> _records = [];
  List<Categories> get categoriesRecords => _records;

  Object? _error;
  Object? get error => _error;

  Future read() async {
    debugPrint("Category Read");
    await BookCategoryService.read(
      onRes: (value) async {
        final data = await value;
        _records = data.data.categories;
        notifyListeners();
      },
      onError: (err) {
        _error = err;
        notifyListeners();
      },
    );
  }
}
