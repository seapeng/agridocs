import 'package:flutter/material.dart';

import 'video_model.dart';
import 'video_service.dart';

class VideoLogic extends ChangeNotifier {
  List<Videos> _records = [];
  List<Videos> get records => _records;

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
    await VideoService.read(
      page: _page,
      onRes: (value) async {
        final data = await value;
        _records += data.data.videos;
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

  Future read() async {
    await VideoService.read(
      onRes: (value) async {
        final data = await value;
        _records = data.data.videos;
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
