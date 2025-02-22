import 'package:flutter/material.dart';
import 'translate_data.dart';

class TranslateLogic extends ChangeNotifier {
  Translate _lang = Khmer();
  Translate get lang => _lang;
  int _langIndex = 0;
  int get langIndex => _langIndex;

  void changToKhmer() {
    _lang = Khmer();
    _langIndex = 0;
    notifyListeners();
  }

  void changeToEnglish() {
    _lang = Translate();
    _langIndex = 1;
    notifyListeners();
  }
}
