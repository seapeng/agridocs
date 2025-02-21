import 'dart:convert';

VideoModel videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));
String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  late bool success;
  late String message;
  late Data data;

  VideoModel({
    required this.success,
    required this.message,
    required this.data,
  });

  VideoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (success) {
      message = json['message'];
      data = Data.fromJson(json['data']);
    } else {
      message = json['message'];
      data = Data(
        videos: [],
        totalRecords: 0,
        totalPages: 0,
        currentPage: 0,
        allowNext: false,
        allowPrevious: false,
        nextPage: 0,
        previousPage: 0,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  late List<Videos> videos;
  late int totalRecords;
  late int totalPages;
  late int currentPage;
  late bool allowNext;
  late bool allowPrevious;
  late int nextPage;
  late int previousPage;

  Data({
    required this.videos,
    required this.totalRecords,
    required this.totalPages,
    required this.currentPage,
    required this.allowNext,
    required this.allowPrevious,
    required this.nextPage,
    required this.previousPage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    videos = List<Videos>.from(json['videos'].map((x) => Videos.fromJson(x)));
    totalRecords = json['totalRecords'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    allowNext = json['allowNext'];
    allowPrevious = json['allowPrevious'];
    nextPage = json['nextPage'];
    previousPage = json['previousPage'];
  }

  Map<String, dynamic> toJson() => {
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "totalRecords": totalRecords,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "allowNext": allowNext,
        "allowPrevious": allowPrevious,
        "nextPage": nextPage,
        "previousPage": previousPage,
      };
}

class Videos {
  int id;
  String title;
  String youtubeId;
  DateTime published;
  String author;
  int videoCategoryId;
  int languageId;
  Language language;
  VideoCategory videoCategory;

  Videos({
    required this.id,
    required this.title,
    required this.youtubeId,
    required this.published,
    required this.author,
    required this.videoCategoryId,
    required this.languageId,
    required this.language,
    required this.videoCategory,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        id: json["id"],
        title: json["title"],
        youtubeId: json["youtubeId"],
        published: DateTime.parse(json['published']),
        author: json["author"],
        videoCategoryId: json["videoCategoryId"],
        languageId: json["languageId"],
        language: Language.fromJson(json["language"]),
        videoCategory: VideoCategory.fromJson(json["videoCategory"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "youtubeId": youtubeId,
        "published": published,
        "author": author,
        "videoCategoryId": videoCategoryId,
        "languageId": languageId,
        "language": language.toJson(),
        "videoCategory": videoCategory.toJson(),
      };
}

class Language {
  late int id;
  late String name;

  Language({
    required this.id,
    required this.name,
  });

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class VideoCategory {
  late int id;
  late String name;

  VideoCategory({
    required this.id,
    required this.name,
  });

  VideoCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
