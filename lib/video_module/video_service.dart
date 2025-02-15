import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'video_model.dart';

class VideoService {
  static Future read({
    int page = 1,
    required Function(Future<VideoModel>) onRes,
    required Function(Object?) onError,
  }) async {
    String url =
        "https://agridocs-api.daovitou.net/mobile/v1/videos?pages=$page&limit=6";
    try {
      http.Response response = await http.get(Uri.parse(url));
      final data = compute(videoModelFromJson, response.body);
      onRes(data);
      onError(null);
    } catch (e) {
      onError(e);
    }
  }

  static Future search({
    required String videoTitle,
    required Function(Future<VideoModel>) onRes,
    required Function(Object?) onError,
  }) async {
    String url =
        "https://agridocs-api.daovitou.net/mobile/v1/videos?search=$videoTitle";
    try {
      http.Response response = await http.get(Uri.parse(url));
      final data = compute(videoModelFromJson, response.body);
      onRes(data);
      onError(null);
    } catch (e) {
      onError(e);
    }
  }
}
