import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For API requests

import 'video_category_model.dart';

class VideoCategoryLogic with ChangeNotifier {
  List<Categories> _categories = [];

  List<Categories> get categories => _categories;

  Future<void> read() async {
    try {
      final response = await http.get(Uri.parse(
          "https://agridocs-api.daovitou.net/mobile/v1/video-categories"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> categoryList = jsonData['data']['categories'];

        _categories =
            categoryList.map((item) => Categories.fromJson(item)).toList();
        _categories.insert(0, Categories(id: 0, name: "ទាំងអស់"));
        notifyListeners();
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
}
