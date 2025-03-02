import 'package:flutter/material.dart';

class ThemeLogic extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;

  bool get dark => _mode == ThemeMode.dark;

  void changeToSystem() {
    _mode = ThemeMode.system;
    notifyListeners();
  }

  void changeToLight() {
    _mode = ThemeMode.light;
    notifyListeners();
  }

  void changeToDark() {
    _mode = ThemeMode.dark;
    notifyListeners();
  }
}
