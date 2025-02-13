import 'dart:convert';
import 'package:http/http.dart' as http;
import 'video_model.dart';

class VideoService {
  final String apiUrl = "https://agridocs-api.daovitou.net/mobile/v1/videos";

  Future<List<VideoModel>> fetchVideos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parse the JSON response
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => VideoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
