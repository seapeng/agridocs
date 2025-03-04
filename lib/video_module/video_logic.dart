import 'package:flutter/material.dart';

import 'video_model.dart';
import 'video_service.dart';

class VideoLogic extends ChangeNotifier {
  List<Videos> _records = [];
  List<Videos> get records => _records;

  bool _loading = false;
  bool get loading => _loading;

  bool _categoryLoading = false;
  bool get categoryLoading => _categoryLoading;

  bool _moreData = false;
  bool get moreData => _moreData;

  Object? _error;
  Object? get error => _error;

  void setLoading() {
    _loading = true;
    notifyListeners();
  }

  void setCategoryLoading() {
    _categoryLoading = true;
    notifyListeners();
  }

  int _page = 1;

  Future readAppend() async {
    _page++;
    await VideoService.read(
      page: _page,
      onRes: (value) async {
        final data = await value;
        _records += data.data.videos;
        _loading = false;
        // if (data.data.totalRecords == _records.length) {
        //   _loading = false;
        // } else {
        //   _loading = true;
        // }
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

  Future read(int categoryId) async {
    await VideoService.read(
      categoryId: categoryId,
      onRes: (value) async {
        final data = await value;
        _records = data.data.videos;
        _loading = false;
        // if (data.data.totalRecords == _records.length) {
        //   _loading = false;
        // } else {
        //   _loading = true;
        // }
        _categoryLoading = false;
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
